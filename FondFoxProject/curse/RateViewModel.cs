using System;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Threading;
using System.Xml.Linq;

namespace FondFoxProject
{
    public class RateViewModel : PropertyChangedBase
    {
        protected Rate curRate;
        protected Rate curRate2;
        protected DispatcherTimer timer;

        public RateViewModel()
        {
            // Создаем курс валюты
            curRate = new Rate();
            curRate2 = new Rate();

            // Создаем таймер, которые каждые 10 секунд получает новый курс доллара
            timer = new DispatcherTimer();
            timer.Tick += new EventHandler(timer_Tick);
            timer.Interval = new TimeSpan(0, 0, 3);
            timer.Start();
        }

        // Обработчик, который вызывается каждые 10 секуд для получения курса доллара
        private async void timer_Tick(object sender, EventArgs e)
        {
            try
            {
                CurRate.Value = await GetRate();
                CurRate2.Value = await GetRate2();
            }
            catch
            {
                MessageBox.Show("Отсутствует подключение к интернету!");
            }
        }

        // Событие случается при загрузке окна программы
        public async Task OnLoad(object sender, RoutedEventArgs e)
        {
            CurRate.Value = await GetRate();
            CurRate2.Value = await GetRate2();
        }

        // Запрос курса доллара с сайта
        protected async Task<double> GetRate()
        {
            using (WebClient client = new WebClient())
            {
                var xml = await client.DownloadStringTaskAsync(new Uri("https://www.cbr-xml-daily.ru/daily.xml"));
                XDocument xdoc = XDocument.Parse(xml);
                var el = xdoc.Element("ValCurs").Elements("Valute");
                string dollar = el.Where(x => x.Attribute("ID").Value == "R01235").Select(x => x.Element("Value").Value).FirstOrDefault();
                if (!string.IsNullOrWhiteSpace(dollar))
                    return Convert.ToDouble(dollar);
            }

            return 0;
        }

        // Запрос курса юаня с сайта
        protected async Task<double> GetRate2()
        {
            using (WebClient client = new WebClient())
            {
                var xml = await client.DownloadStringTaskAsync(new Uri("https://www.cbr-xml-daily.ru/daily.xml"));
                XDocument xdoc = XDocument.Parse(xml);
                var el = xdoc.Element("ValCurs").Elements("Valute");
                string yan = el.Where(x => x.Attribute("ID").Value == "R01375").Select(x => x.Element("Value").Value).FirstOrDefault();
                if (!string.IsNullOrWhiteSpace(yan))
                    return Convert.ToDouble(yan);
            }

            return 0;
        }

        // Свойство в котором хранится курс доллара
        public Rate CurRate
        {
            get { return curRate; }
            set
            {
                curRate = value;
                OnPropertyChanged("CurRate");
            }
        }

        // Свойство в котором хранится курс юань
        public Rate CurRate2
        {
            get { return curRate2; }
            set
            {
                curRate = value;
                OnPropertyChanged("CurRate2");
            }
        }
    }
}
