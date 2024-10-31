using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace FondFoxProject
{
    public partial class DepartmentWindow : Window
    {
        private Users _user;
        private Department _department;
        FondFoxDBEntities database = new FondFoxDBEntities();
        List<Users> users;
        private Users selectedUser;

        public DepartmentWindow(Users user)
        {
            InitializeComponent();
            _user = user;

            users = database.Users.ToList();
            userDataGrid.ItemsSource = users;

            if (_user.role == 2)
            {
                addUserBTN.IsEnabled = true;
                deleteUserBTN.IsEnabled = true;
            }
            LoadUserData();
        }

        private void LoadUserData()
        {
            _department = database.Department.FirstOrDefault(r => r.id == _user.department);
            var otdelName = _department?.namedepartment;
            var descriptionName = _department?.description;

            nameotdelLBL.Content = otdelName;
            descriptionLBL.Text = descriptionName;
        }

        private void backBTN_Click(object sender, RoutedEventArgs e)
        {
            UserWindow userWindow = new UserWindow(_user);
            userWindow.Show();
            this.Close();
        }

        private void closeBTN_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void userDataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            selectedUser = userDataGrid.SelectedItem as Users;
            if (selectedUser != null)
            {
                addUserBTN.IsEnabled = selectedUser.department == null;
                deleteUserBTN.IsEnabled = selectedUser.department == _department?.id;
            }
        }

        private void addUserBTN_Click(object sender, RoutedEventArgs e)
        {
            if (selectedUser != null && selectedUser.department == null)
            {
                selectedUser.department = _department.id;
                database.SaveChanges();
                MessageBox.Show("Сотрудник добавлен в отдел.");
                userDataGrid.ItemsSource = database.Users.ToList();
            }
            else
            {
                MessageBox.Show("Сотрудник уже находится в отделе или не выбран.");
            }
        }

        private void deleteUserBTN_Click(object sender, RoutedEventArgs e)
        {
            if (selectedUser != null && selectedUser.department == _department.id)
            {
                selectedUser.department = null;
                database.SaveChanges();
                MessageBox.Show("Сотрудник удален из отдела.");
                userDataGrid.ItemsSource = database.Users.ToList();
            }
            else
            {
                MessageBox.Show("Сотрудник не находится в данном отделе или не выбран.");
            }
        }
    }
}