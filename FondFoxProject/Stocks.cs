//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace FondFoxProject
{
    using System;
    using System.Collections.Generic;
    
    public partial class Stocks
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Stocks()
        {
            this.Orders = new HashSet<Orders>();
            this.Portfel = new HashSet<Portfel>();
        }
    
        public int id { get; set; }
        public string namestock { get; set; }
        public string description { get; set; }
        public Nullable<int> typestock { get; set; }
        public Nullable<decimal> price { get; set; }
        public string photo { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Orders> Orders { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Portfel> Portfel { get; set; }
        public virtual TypeStock TypeStock1 { get; set; }
    }
}
