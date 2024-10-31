using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.IO;
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
    /// Логика взаимодействия для TradingWindow.xaml
    /// </summary>
    public partial class TradingWindow : Window
    {
        FondFoxDBEntities database = new FondFoxDBEntities();
        private string selectedImageFileName;
        Users _user;
        public TradingWindow(Users user)
        {
            InitializeComponent();
            LoadStockData();
            LoadCategories();
            LoadOrdersData();
            LoadNewsData();
            LoadStockTypes();
            _user = user;

            if (_user.role == 3)
                lastnewsBTN.Visibility = Visibility.Visible;
            else
                lastnewsBTN.Visibility = Visibility.Collapsed;
        }

        private void LoadOrdersData()
        {
            var ordersData = (from o in database.Orders
                              join u in database.Users on o.user_id equals u.id
                              join s in database.Stocks on o.stock_id equals s.id
                              join t in database.TypeOrder on o.typeorder equals t.id
                              select new
                              {
                                  OrderId = o.id,
                                  UserLogin = u.login,
                                  StockName = s.namestock,
                                  TypeOrder = t.nametype,
                                  Price = o.price,
                                  Cost = o.cost,
                                  Date = o.date
                              }).ToList();

            ordersDataGrid.ItemsSource = ordersData;
            ordersDataGrid.AutoGenerateColumns = false;

            // Очистим колонки и добавим новые
            ordersDataGrid.Columns.Clear();

            ordersDataGrid.Columns.Add(new DataGridTextColumn { Header = "ID", Binding = new Binding("OrderId") });
            ordersDataGrid.Columns.Add(new DataGridTextColumn { Header = "Логин", Binding = new Binding("UserLogin") });
            ordersDataGrid.Columns.Add(new DataGridTextColumn { Header = "Акция", Binding = new Binding("StockName") });
            ordersDataGrid.Columns.Add(new DataGridTextColumn { Header = "Тип транзакции", Binding = new Binding("TypeOrder") });
            ordersDataGrid.Columns.Add(new DataGridTextColumn { Header = "Сумма", Binding = new Binding("Price") });
            ordersDataGrid.Columns.Add(new DataGridTextColumn { Header = "Количество", Binding = new Binding("Cost") });
            ordersDataGrid.Columns.Add(new DataGridTextColumn { Header = "Дата", Binding = new Binding("Date") });
        }

        private void LoadNewsData()
        {
            var newsData = (from n in database.News
                            join d in database.Department on n.department equals d.id
                            select new
                            {
                                Id = n.id,
                                Message = n.message,
                                Date = n.date,
                                Department = d.namedepartment
                            }).ToList();

            newsDataGrid.ItemsSource = newsData;
        }

        private void AddNews()
        {
            if (string.IsNullOrEmpty(messageTXT.Text))
            {
                MessageBox.Show("Введите сообщение.");
                return;
            }

            if (_user.department.HasValue)
            {
                int userDepartmentId = _user.department.Value;

                News news = new News()
                {
                    message = messageTXT.Text,
                    date = DateTime.Now,
                    department = userDepartmentId
                };

                database.News.Add(news);
                database.SaveChanges();
                MessageBox.Show("Новость успешно добавлена.");
                LoadNewsData(); // Обновляем список новостей
            }
            else
            {
                MessageBox.Show("У пользователя не указан отдел.");
            }
        }

        private void LoadStockData()
        {
            var stockData = database.Stocks.Select(s => new
            {
                Id = s.id,
                NameStock = s.namestock,
                Description = s.description,
                TypeStock = s.typestock,
                Price = s.price,
                Photo = s.photo
            }).ToList();

            var stocks = stockData.Select(s => new Stocks
            {
                id = s.Id,
                namestock = s.NameStock,
                description = s.Description,
                typestock = s.TypeStock,
                price = s.Price,
                photo = GetImagePath(s.Photo)
            }).ToList();

            stocksListView.ItemsSource = stocks;
        }

        private void LoadCategories()
        {
            var categories = database.TypeStock.ToList();

            // Добавляем категорию "Все"
            categories.Insert(0, new TypeStock { id = -1, name = "Все" });

            categoryCMB.ItemsSource = categories;
            categoryCMB.DisplayMemberPath = "name";
            categoryCMB.SelectedValuePath = "id";
            categoryCMB.SelectedValue = -1; // Устанавливаем категорию "Все" по умолчанию 
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

        private void strockBTN_Click(object sender, RoutedEventArgs e)
        {
            UpdateButtonStyles(sender as Button);
            Page1.Visibility = Visibility.Visible;
            Page2.Visibility = Visibility.Collapsed;
            Page3.Visibility = Visibility.Collapsed;
            Page4.Visibility = Visibility.Collapsed;
        }

        private void strocktimeBTN_Click(object sender, RoutedEventArgs e)
        {
            UpdateButtonStyles(sender as Button);
            Page2.Visibility = Visibility.Visible;
            Page1.Visibility = Visibility.Collapsed;
            Page3.Visibility = Visibility.Collapsed;
            Page4.Visibility = Visibility.Collapsed;
        }

        private void orderBTN_Click(object sender, RoutedEventArgs e)
        {
            UpdateButtonStyles(sender as Button);
            Page3.Visibility = Visibility.Visible;
            Page2.Visibility = Visibility.Collapsed;
            Page1.Visibility = Visibility.Collapsed;
            Page4.Visibility = Visibility.Collapsed;
        }

        private void lastnewsBTN_Click(object sender, RoutedEventArgs e)
        {
            UpdateButtonStyles(sender as Button);
            Page4.Visibility = Visibility.Visible;
            Page2.Visibility = Visibility.Collapsed;
            Page3.Visibility = Visibility.Collapsed;
            Page1.Visibility = Visibility.Collapsed;
        }

        private void UpdateButtonStyles(Button activeButton)
        {
            var buttons = new Button[] { strockBTN, strocktimeBTN, orderBTN, lastnewsBTN, profileBTN };

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

        private void stocksListView_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            var selectedStock = stocksListView.SelectedItem as Stocks;
            if (selectedStock != null)
            {
                StockWindow stockWindow = new StockWindow(selectedStock, _user);
                stockWindow.ShowDialog();
            }
        }

        private void searchBTN_Click(object sender, RoutedEventArgs e)
        {
            string nameFilter = namestockTXT.Text.ToLower();
            int? categoryFilter = categoryCMB.SelectedValue as int?;

            var filteredStocks = database.Stocks.AsQueryable();

            if (!string.IsNullOrEmpty(nameFilter))
            {
                filteredStocks = filteredStocks.Where(stock => stock.namestock.ToLower().Contains(nameFilter));
            }

            if (categoryFilter.HasValue)
            {
                filteredStocks = filteredStocks.Where(stock => stock.typestock == categoryFilter.Value);
            }

            var stockData = filteredStocks.Select(s => new
            {
                Id = s.id,
                NameStock = s.namestock,
                Description = s.description,
                TypeStock = s.typestock,
                Price = s.price,
                Photo = s.photo
            }).ToList();

            var stocks = stockData.Select(s => new Stocks
            {
                id = s.Id,
                namestock = s.NameStock,
                description = s.Description,
                typestock = s.TypeStock,
                price = s.Price,
                photo = GetImagePath(s.Photo)
            }).ToList();

            stocksListView.ItemsSource = stocks;
        }

        private void messegeBTN_Click(object sender, RoutedEventArgs e)
        {
            AddNews();
        }

        private void imageBTN_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Filter = "Image files (*.png;*.jpeg;*.jpg)|*.png;*.jpeg;*.jpg";

            if (openFileDialog.ShowDialog() == true)
            {
                string baseDirectory = AppDomain.CurrentDomain.BaseDirectory;
                string imagesFolder = "..\\..\\ImageStock\\";
                string destinationFolder = System.IO.Path.Combine(baseDirectory, imagesFolder);

                if (!Directory.Exists(destinationFolder))
                {
                    Directory.CreateDirectory(destinationFolder);
                }

                string fileName = System.IO.Path.GetFileName(openFileDialog.FileName);
                string destinationPath = System.IO.Path.Combine(destinationFolder, fileName);

                try
                {
                    File.Copy(openFileDialog.FileName, destinationPath, true);
                    selectedImageFileName = fileName;
                    MessageBox.Show("Изображение успешно загружено.");
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при копировании файла: {ex.Message}");
                }
            }
        }

        private void LoadStockTypes()
        {
            var stockTypes = database.TypeStock.ToList();
            newtypeTXT.ItemsSource = stockTypes;
            newtypeTXT.DisplayMemberPath = "name";
            newtypeTXT.SelectedValuePath = "id";
        }

        private void AddStockBTN_Click(object sender, RoutedEventArgs e)
        {
            string name = NEWnamestockTXT.Text;
            string description = NEWdescriptionTXT.Text;
            string priceText = NEWpriceTXT.Text;
            int? typeId = newtypeTXT.SelectedValue as int?;

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(description) || string.IsNullOrEmpty(priceText) || !typeId.HasValue)
            {
                MessageBox.Show("Заполните все поля.");
                return;
            }

            if (!decimal.TryParse(priceText, out decimal price))
            {
                MessageBox.Show("Введите корректную стоимость.");
                return;
            }

            if (string.IsNullOrEmpty(selectedImageFileName))
            {
                MessageBox.Show("Пожалуйста, выберите изображение.");
                return;
            }

            Stocks newStock = new Stocks()
            {
                namestock = name,
                description = description,
                price = price,
                typestock = typeId.Value,
                photo = selectedImageFileName // Сохраняем только имя файла изображения
            };

            try
            {
                database.Stocks.Add(newStock);
                database.SaveChanges();
                MessageBox.Show("Новая акция успешно добавлена.");
                LoadStockData(); // Обновляем список акций

                // Очищаем поля после добавления акции
                NEWnamestockTXT.Text = string.Empty;
                NEWdescriptionTXT.Text = string.Empty;
                NEWpriceTXT.Text = string.Empty;
                newtypeTXT.SelectedIndex = -1;
                selectedImageFileName = null;
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
            {
                StringBuilder errorMessages = new StringBuilder();

                foreach (var validationErrors in dbEx.EntityValidationErrors)
                {
                    foreach (var validationError in validationErrors.ValidationErrors)
                    {
                        errorMessages.AppendLine($"{validationError.PropertyName}: {validationError.ErrorMessage}");
                    }
                }

                MessageBox.Show(errorMessages.ToString(), "Ошибка валидации данных");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Произошла ошибка: {ex.Message}");
            }
        }
    }
}