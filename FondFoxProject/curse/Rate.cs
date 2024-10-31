namespace FondFoxProject
{
    public class Rate : PropertyChangedBase
    {
        protected double val;

        // Числовое значение
        public double Value
        {
            get
            {
                return val;
            }
            set
            {
                val = value;
                OnPropertyChanged("Value");
            }
        }
    }
}
