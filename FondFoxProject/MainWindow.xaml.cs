using System;
using System.Linq;
using System.Windows;

namespace FondFoxProject
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        FondFoxDBEntities database = new FondFoxDBEntities();
        protected RateViewModel viewModel;
        public MainWindow()
        {
            InitializeComponent();

            DataContext = viewModel = new RateViewModel();
        }

        private void entryBTN_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var user = database.Users.FirstOrDefault(x => x.login == loginTXT.Text && x.password == passwordTXT.Text);

                if (user != null)
                {
                    // Добавляем запись в историю входов
                    var newLoginHistory = new LoginHistory
                    {
                        user_id = user.id,
                        date = DateTime.Now,
                        result = true,
                    };

                    database.LoginHistory.Add(newLoginHistory);
                    database.SaveChanges();

                    // Открываем окно пользователя и передаем данные пользователя
                    UserWindow userWindow = new UserWindow(user);
                    userWindow.Show();
                    this.Close();
                }
                else
                {
                    // Добавляем запись о неудачной попытке входа
                    var newLoginHistory = new LoginHistory
                    {
                        user_id = database.Users.FirstOrDefault(u => u.login == loginTXT.Text)?.id ?? -1,
                        date = DateTime.Now,
                        result = false,
                    };

                    database.LoginHistory.Add(newLoginHistory);
                    database.SaveChanges();
                    MessageBox.Show("Пользователь не найден или неверный пароль!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Произошла ошибка: " + ex.Message);
            }
        }
        private async void OnLoad(object sender, RoutedEventArgs e)
        {
            await viewModel.OnLoad(sender, e);
        }

        private void closeBTN_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
