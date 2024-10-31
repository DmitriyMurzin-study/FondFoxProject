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
    /// Логика взаимодействия для InfousersWindow.xaml
    /// </summary>
    public partial class InfousersWindow : Window
    {
        FondFoxDBEntities database = new FondFoxDBEntities();
        Users _user;
        private int roleid = 0;
        public InfousersWindow(Users users)
        {
            InitializeComponent();
            LoadUsers();
            _user = users;
        }

        private void backBTN_Click(object sender, RoutedEventArgs e)
        {
            UserWindow userWindow = new UserWindow(_user);
            userWindow.Show();
            this.Close();
        }
        // Метод для загрузки пользователей и отображения в DataGrid
        private void LoadUsers()
        {
            try
            {
                var users = database.Users.ToList(); // Получаем список всех пользователей из базы данных
                datagridUSER.ItemsSource = users; // Устанавливаем этот список в качестве источника данных для DataGrid

            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при загрузке пользователей: {ex.Message}");
            }
        }
        private void closeBTN_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void addUserBTN_Click(object sender, RoutedEventArgs e)
        {
            if (stbrokerCHECK.IsChecked == true)
                roleid = 2;
            else
                roleid = 1;

            // Проверка на наличие цифр в полях имени
            if (firstnameTXT.Text.Any(char.IsDigit) ||
                secondnameTXT.Text.Any(char.IsDigit) ||
                fathernameTXT.Text.Any(char.IsDigit))
            {
                MessageBox.Show("Поля имени не могут содержать цифры.");
                return;
            }

            // Проверка на уникальность логина
            string login = loginTXT.Text.Trim();
            var existingUser = database.Users.FirstOrDefault(u => u.login == login);
            if (existingUser != null)
            {
                MessageBox.Show("Пользователь с таким логином уже существует. Пожалуйста, выберите другой логин.");
                return;
            }

            // Создание нового пользователя и сохранение в базе данных
            Users newUser = new Users()
            {
                firstname = firstnameTXT.Text,
                lastname = secondnameTXT.Text,
                fathername = fathernameTXT.Text,
                email = emailTXT.Text,
                login = login,
                password = passwordTXT.Text,
                role = roleid
            };

            database.Users.Add(newUser);
            database.SaveChanges();

            MessageBox.Show("Пользователь успешно добавлен.");
        }

        private void deleteUserBTN_Click(object sender, RoutedEventArgs e)
        {
            // Получаем id пользователя для удаления
            if (!int.TryParse(idTXT.Text, out int userId))
            {
                MessageBox.Show("Введите корректный ID пользователя для удаления.");
                return;
            }

            // Находим пользователя по id
            var userToDelete = database.Users.FirstOrDefault(u => u.id == userId);
            if (userToDelete == null)
            {
                MessageBox.Show($"Пользователь с ID {userId} не найден.");
                return;
            }

            // Запрашиваем подтверждение перед удалением
            MessageBoxResult result = MessageBox.Show($"Вы уверены, что хотите удалить пользователя {userToDelete.firstname}?",
                                                      "Подтверждение удаления пользователя",
                                                      MessageBoxButton.YesNo,
                                                      MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                try
                {
                    // Удаляем пользователя из базы данных
                    database.Users.Remove(userToDelete);
                    database.SaveChanges();
                    MessageBox.Show($"Пользователь {userToDelete.firstname} удалён.");
                    LoadUsers();
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при удалении пользователя: {ex.Message}");
                }
            }
        } 
    }
}
