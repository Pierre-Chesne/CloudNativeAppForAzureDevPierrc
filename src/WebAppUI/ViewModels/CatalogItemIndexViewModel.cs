﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CnAppForAzureDev.ViewModels
{
    public class CatalogItemIndexViewModel
    {
        public string FormAspAction { get; set; }

        public string FormAspArea { get; set; }

        public string FormAspController { get; set; }

        public string FormSubmitButtonIconCssClass { get; set; }

        public string FormSubmitButtonText { get; set; }

        public IEnumerable<CatalogItemViewModel> Items { get; set; }
    }
}
