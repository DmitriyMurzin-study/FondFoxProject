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
    
    public partial class News
    {
        public int id { get; set; }
        public string message { get; set; }
        public Nullable<System.DateTime> date { get; set; }
        public Nullable<int> department { get; set; }
    
        public virtual Department Department1 { get; set; }
    }
}
