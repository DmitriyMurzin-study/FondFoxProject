using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
    /// Логика взаимодействия для BriefcaseWindow.xaml
    /// </summary>
    public partial class BriefcaseWindow : Window
    {
        FondFoxDBEntities database = new FondFoxDBEntities();
        Users _user;
        public BriefcaseWindow(Users users)
        {
            InitializeComponent();
            _user = users;
            LoadStockData();
            LoadCategories();
            LoadUserTransactions();
        }
        private void LoadStockData()
        {
            var userStocks = from p in database.Portfel
                             join s in database.Stocks on p.stock_id equals s.id
                             where p.user_id == _user.id
                             select new
                             {
                                 Id = s.id,
                                 NameStock = s.namestock,
                                 Description = s.description,
                                 TypeStock = s.typestock,
                                 Price = s.price,
                                 Photo = s.photo
                             };

            var stockList = userStocks.ToList().Select(s => new Stocks
            {
                id = s.Id,
                namestock = s.NameStock,
                description = s.Description,
                typestock = s.TypeStock,
                price = s.Price,
                photo = GetImagePath(s.Photo)
            }).ToList();

            stocksListView.ItemsSource = stockList;
        }

        private string GetImagePath(string photoFileName)
        {
            string baseDirectory = AppDomain.CurrentDomain.BaseDirectory;
            string imagesFolder = "..\\..\\ImageStock\\";
            string fullPath = System.IO.Path.Combine(baseDirectory, imagesFolder, photoFileName);

            if (!System.IO.File.Exists(fullPath))
            {
                // Если файл не существует, можно задать путь к изображению по умолчанию
                return System.IO.Path.Combine(baseDirectory, imagesFolder, "default.png");
            }

            return new Uri(fullPath).AbsoluteUri;
        }

        private void LoadCategories()
        {
            var categories = database.TypeOrder.ToList();

            // Добавляем категорию "Все"
            categories.Insert(0, new TypeOrder { id = -1, nametype = "Все" });

            operationTypeCMB.ItemsSource = categories;
            operationTypeCMB.DisplayMemberPath = "nametype";
            operationTypeCMB.SelectedValuePath = "id";
            operationTypeCMB.SelectedValue = -1; // Устанавливаем категорию "Все" по умолчанию 
        }

        private void LoadUserTransactions(int? operationType = null)
        {
            var userTransactions = from o in database.Orders
                                   join s in database.Stocks on o.stock_id equals s.id
                                   join t in database.TypeOrder on o.typeorder equals t.id
                                   where o.user_id == _user.id
                                   select new
                                   {
                                       OrderId = o.id,
                                       StockName = s.namestock,
                                       TypeOrder = t.nametype,
                                       TypeOrderId = t.id, // добавляем поле для фильтрации
                                       Price = o.price,
                                       Cost = o.cost,
                                       Date = o.date
                                   };

            if (operationType.HasValue && operationType != -1)
            {
                userTransactions = userTransactions.Where(t => t.TypeOrderId == operationType.Value);
            }

            var ordersData = userTransactions.ToList();

            transactionsDataGrid.ItemsSource = ordersData;
            transactionsDataGrid.AutoGenerateColumns = false;

            // Очистим колонки и добавим новые
            transactionsDataGrid.Columns.Clear();

            transactionsDataGrid.Columns.Add(new DataGridTextColumn { Header = "ID", Binding = new Binding("OrderId") });
            transactionsDataGrid.Columns.Add(new DataGridTextColumn { Header = "Акция", Binding = new Binding("StockName") });
            transactionsDataGrid.Columns.Add(new DataGridTextColumn { Header = "Тип транзакции", Binding = new Binding("TypeOrder") });
            transactionsDataGrid.Columns.Add(new DataGridTextColumn { Header = "Сумма", Binding = new Binding("Price") });
            transactionsDataGrid.Columns.Add(new DataGridTextColumn { Header = "Количество", Binding = new Binding("Cost") });
            transactionsDataGrid.Columns.Add(new DataGridTextColumn { Header = "Дата", Binding = new Binding("Date") });
        }

        private void mystockBTN_Click(object sender, RoutedEventArgs e)
        {
            UpdateButtonStyles(sender as Button);
            page1.Visibility = Visibility.Visible;
            page2.Visibility = Visibility.Hidden;
        }

        private void tranzactionBTN_Click(object sender, RoutedEventArgs e)
        {
            UpdateButtonStyles(sender as Button);
            page2.Visibility = Visibility.Visible;
            page1.Visibility = Visibility.Hidden;
        }
        private void UpdateButtonStyles(Button activeButton)
        {
            var buttons = new Button[] { mystockBTN, tranzactionBTN};

            foreach (var button in buttons)
            {
                if (button == activeButton)
                {
                    button.Background = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#FFFF6900"));
                    button.Foreground = Brushes.White;
                    button.FontWeight = FontWeights.Bold;
                }
                else
                {
                    button.Background = Brushes.White;
                    button.Foreground = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#FFFF6900"));
                    button.FontWeight = FontWeights.Normal;
                }
            }
        }

        private void profileBTN_Click(object sender, RoutedEventArgs e)
        {
            UserWindow userWindow = new UserWindow(_user);
            userWindow.Show();
            this.Close();
        }

        private void closeBTN_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void operationTypeCMB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selectedOperationType = (operationTypeCMB.SelectedItem as TypeOrder)?.id;
            LoadUserTransactions(selectedOperationType);
        }

        private void stocksListView_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            var selectedStock = stocksListView.SelectedItem as Stocks;
            if (selectedStock != null)
            {
                StocksPortfilWindow stockWindow = new StocksPortfilWindow(selectedStock, _user);
                stockWindow.ShowDialog();
            }
        }
    }
}
