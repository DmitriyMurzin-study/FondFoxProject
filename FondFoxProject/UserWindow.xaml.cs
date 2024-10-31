using Microsoft.Win32;
using System;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Media.Imaging;

namespace FondFoxProject
{
    public partial class UserWindow : Window
    {
        private Users _user;
        FondFoxDBEntities database = new FondFoxDBEntities();
        public UserWindow(Users user)
        {
            InitializeComponent();
            _user = user;
            LoadUserData();
            LoadLoginHistory();
            if (_user.role == 3)
            {
                infoUsersBTN.Visibility = Visibility.Visible;
                historyBTN.Visibility = Visibility.Visible;
            }
            else
            {
                infoUsersBTN.Visibility = Visibility.Collapsed;
                historyBTN.Visibility = Visibility.Collapsed;
            }
                

        }

        private void LoadUserData()
        {
            var roleName = database.Role.FirstOrDefault(r => r.id == _user.role)?.namerole;

            // Fill the UI with user data
            usernameLBL.Content = $"{_user.lastname} {_user.firstname} {_user.fathername}";
            emailLBL.Content = _user.email;
            roleLBL.Content = roleName;
            summLBL.Content = _user.balance;

            // Load the user's photo if available
            if (!string.IsNullOrEmpty(_user.photo))
            {
                var photoPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, _user.photo);
                if (File.Exists(photoPath))
                {
                    photo.Source = new BitmapImage(new Uri(photoPath));
                }
            }
        }

        private void deportamentBTN_Click(object sender, RoutedEventArgs e)
        {
            DepartmentWindow departmentWindow = new DepartmentWindow(_user);
            departmentWindow.Show();
            this.Close();
        }

        private void tradingBTN_Click(object sender, RoutedEventArgs e)
        {
            TradingWindow TradingWindow = new TradingWindow(_user);
            TradingWindow.Show();
            this.Close();
        }

        private void brifBTN_Click(object sender, RoutedEventArgs e)
        {
            BriefcaseWindow BriefcaseWindow = new BriefcaseWindow(_user);
            BriefcaseWindow.Show();
            this.Close();
        }

        private void infoUsersBTN_Click(object sender, RoutedEventArgs e)
        {
            InfousersWindow InfousersWindow = new InfousersWindow(_user);
            InfousersWindow.Show();
            this.Close();
        }

        private void closeBTN_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void photoBTN_Click(object sender, RoutedEventArgs e)
        {

        }

        private void LoadLoginHistory(string sortBy = "", string loginFilter = "", DateTime? dateFilter = null)
        {
            var loginHistoryQuery = from lh in database.LoginHistory
                                    join u in database.Users on lh.user_id equals u.id
                                    select new
                                    {
                                        Login = u.login,
                                        Date = lh.date,
                                        Result = lh.result ?? false // Установить значение по умолчанию для nullable boolean
                                    };

            // Apply login filter
            if (!string.IsNullOrEmpty(loginFilter))
            {
                loginHistoryQuery = loginHistoryQuery.Where(lh => lh.Login.Contains(loginFilter));
            }

            // Apply date filter
            if (dateFilter.HasValue)
            {
                loginHistoryQuery = loginHistoryQuery.Where(lh => DbFunctions.TruncateTime(lh.Date) == dateFilter.Value.Date);
            }

            // Apply sorting
            switch (sortBy)
            {
                case "login":
                    loginHistoryQuery = loginHistoryQuery.OrderBy(lh => lh.Login);
                    break;
                case "date":
                    loginHistoryQuery = loginHistoryQuery.OrderBy(lh => lh.Date);
                    break;
                default:
                    loginHistoryQuery = loginHistoryQuery.OrderBy(lh => lh.Date); // Default sort by date
                    break;
            }

            // Load data into ListBox
            loginHistoryListBox.Items.Clear();
            foreach (var entry in loginHistoryQuery.ToList())
            {
                loginHistoryListBox.Items.Add($"{entry.Login} - {entry.Date} - {(entry.Result ? "Success" : "Failure")}");
            }
        }

        private void loginSortBTN_Click(object sender, RoutedEventArgs e)
        {
            string loginFilter = loginSortTXT.Text;
            LoadLoginHistory("login", loginFilter);
        }

        private void dataSortBTN_Click(object sender, RoutedEventArgs e)
        {
            DateTime? dateFilter = dataSortTXT.SelectedDate;
            LoadLoginHistory("date", "", dateFilter);
        }

        private void closeHistory_Click(object sender, RoutedEventArgs e)
        {
            historyGrid.Visibility = Visibility.Collapsed;
        }

        private void historyBTN_Click(object sender, RoutedEventArgs e)
        {
            historyGrid.Visibility=Visibility.Visible;
        }
    }
}
