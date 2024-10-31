using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace FondFoxProject
{
    /// <summary>
    /// Логика взаимодействия для StocksPortfilWindow.xaml
    /// </summary>
    public partial class StocksPortfilWindow : Window
    {
        FondFoxDBEntities database = new FondFoxDBEntities();
        private Stocks _stock;
        private Users _user;
        public StocksPortfilWindow(Stocks stocks, Users users)
        {
            InitializeComponent();
            _stock = stocks;
            _user = users;
            LoadStockDetails();
        }
        private void LoadStockDetails()
        {
            var catigoriname = database.TypeStock.FirstOrDefault(r => r.id == _stock.typestock)?.name;

            namestockLBL.Content = _stock.namestock;
            descriptionTXT.Text = _stock.description;
            priceLBL.Content = _stock.price;
            catigoryLBL.Text = catigoriname;
        }
        private void closeBTN_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void plusBTN_Click(object sender, RoutedEventArgs e)
        {
            int currentValue = 0;
            if (int.TryParse(costTXT.Text, out currentValue))
            {
                currentValue += 1;
                costTXT.Text = currentValue.ToString();
            }
            else
            {
                costTXT.Text = "1";
            }
        }

        private void minusBTN_Click(object sender, RoutedEventArgs e)
        {
            int currentValue = 0;
            if (int.TryParse(costTXT.Text, out currentValue))
            {
                currentValue -= 1;
                costTXT.Text = currentValue.ToString();
            }
            else
            {
                costTXT.Text = "0";
            }
        }

        private void costTXT_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            Regex regex = new Regex("[^0-9]+"); // Регулярное выражение для нецифровых символов
            e.Handled = regex.IsMatch(e.Text);
        }

        private void buyBTN_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Проверка ввода количества
                if (!int.TryParse(costTXT.Text, out int cost) || cost <= 0)
                {
                    MessageBox.Show("Введите корректное количество.");
                    return;
                }

                // Проверка ввода цены
                if (!decimal.TryParse(priceLBL.Content.ToString(), out decimal price))
                {
                    MessageBox.Show("Ошибка при получении цены.");
                    return;
                }

                // Создание нового заказа
                Orders order = new Orders
                {
                    user_id = _user.id,
                    stock_id = _stock.id,
                    typeorder = 1,
                    price = price * Convert.ToDecimal(costTXT.Text),
                    cost = cost,
                    date = DateTime.Now,
                };
                Portfel portfel = new Portfel
                {
                    user_id = _user.id,
                    stock_id = _stock.id,
                    cost = cost,
                };
                // Добавление заказа в базу данных
                database.Orders.Add(order);
                database.Portfel.Add(portfel);
                database.SaveChanges();

                // Сообщение об успешном оформлении заказа
                MessageBox.Show("Акции добавлены в портфель.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при добавлении акций: " + ex.Message);
            }
        }

        private void outBTN_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Проверка ввода количества
                if (!int.TryParse(costTXT.Text, out int cost) || cost <= 0)
                {
                    MessageBox.Show("Введите корректное количество.");
                    return;
                }

                // Проверка наличия акции в портфеле пользователя
                var userStock = database.Portfel.FirstOrDefault(p => p.user_id == _user.id && p.stock_id == _stock.id);

                if (userStock == null || userStock.cost < cost)
                {
                    MessageBox.Show("Недостаточно акций для продажи.");
                    return;
                }

                // Проверка ввода цены
                if (!decimal.TryParse(priceLBL.Content.ToString(), out decimal price))
                {
                    MessageBox.Show("Ошибка при получении цены.");
                    return;
                }

                // Создание нового заказа
                Orders order = new Orders
                {
                    user_id = _user.id,
                    stock_id = _stock.id,
                    typeorder = 2, // Тип операции "продажа"
                    price = price * cost,
                    cost = cost,
                    date = DateTime.Now,
                };

                // Обновление количества акций в портфеле
                userStock.cost -= cost;
                if (userStock.cost == 0)
                {
                    database.Portfel.Remove(userStock);
                }

                // Добавление заказа в базу данных
                database.Orders.Add(order);
                database.SaveChanges();

                // Сообщение об успешной продаже
                MessageBox.Show("Акции проданы.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при продаже акций: " + ex.Message);
            }
        }
    }
}
