using CnAppForAzureDev.Entities;
using CnAppForAzureDev.Repositories.Specifications;

using Microsoft.Extensions.Localization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CnAppForAzureDev.Repositories
{
    //TODO : Etape 1 - Utilisation d'un compte de stockage Azure  
    public class CatalogItemRepository : ICatalogItemRepository, IRepository<CatalogItem>
    {
        
        private List<CatalogItem> _catalogItems;

        private readonly IStringLocalizer<CatalogItemRepository> _localizer;
        public CatalogItemRepository(IStringLocalizer<CatalogItemRepository> localizer)
        {
            _localizer = localizer;            
        }
        public Task<CatalogItem> AddAsync(CatalogItem entity)
        {
            throw new NotImplementedException();
        }

        public async Task<CatalogItem> AddAsync(string ownerId, string productName, string productPictureUrl)
        {
            CatalogItem newItem = new CatalogItem
            {
                OwnerId = ownerId,
                ProductName = productName,
                ProductPictureUrl = productPictureUrl,
                Id = Guid.NewGuid().ToString(),
                ProductId = Guid.NewGuid().ToString()
            };
            _catalogItems.Add(newItem);
            return newItem;
        }

        public Task<CatalogItem> GetAsync(string id)
        {
            var q = _catalogItems.Where(item => item.Id == id).Select(i => i).FirstOrDefault();
            return Task.FromResult(q);
        }

        public Task<List<CatalogItem>> ListAsync(string hostname)
        {
           if (_catalogItems == null)
            {
                _catalogItems = new List<CatalogItem>
                {
                    new CatalogItem
                    {
                        Id = "3696d034-deec-4ea3-8977-23558949b61c",
                        OwnerId = "1",
                        ProductId = "abe5a167-8d20-4ad9-9f67-ad54b3e09ef2",
                        ProductName = _localizer["Apples"],
                        ProductPictureUrl = $"{hostname}/images/groceries/apples.jpg"
                    },
                    new CatalogItem
                    {
                        Id = "730b79be-9a4a-4221-a2e1-248d4ed785a9",
                        OwnerId = "1",
                        ProductId = "0740b12d-c2db-44da-911e-8fd45a665d06",
                        ProductName =  _localizer["Bananas"],
                        ProductPictureUrl = $"{hostname}/images/groceries/bananas.jpg"
                    },
                    new CatalogItem
                    {
                        Id = "11ed2c06-88a6-4bf2-ae63-6f8638ed6044",
                        OwnerId = "1",
                        ProductId = "85ebc8d2-1912-488b-9925-2d5c2baaf26f",
                        ProductName = _localizer["Oranges"],
                        ProductPictureUrl = $"{hostname}/images/groceries/oranges.jpg"
                    },
                    new CatalogItem
                    {
                        Id = "a02af65f-507d-472d-be5f-e2f20fc94212",
                        OwnerId = "1",
                        ProductId = "f5f808d9-0da5-4a6d-abf2-21582eec000f",
                        ProductName =_localizer["Milk"],
                        ProductPictureUrl = $"{hostname}/images/groceries/milk-1056475.jpg",
                        ProductAllergyInfo = "Dairy"
                    },
                    new CatalogItem
                    {
                        Id = "db02856c-21b7-4510-aa27-6862620c326b",
                        OwnerId = "1",
                        ProductId = "c734e865-e376-4ef2-a1c1-1049da318278",
                        ProductName = _localizer["Bulk Nuts"],
                        ProductPictureUrl = $"{hostname}/images/groceries/peanut-1328063.jpg",
                        ProductAllergyInfo = "Nuts"
                    },
                    new CatalogItem
                    {
                        Id = "85dc4475-a56f-4e64-9877-1717a9622279",
                        OwnerId = "1",
                        ProductId = "0d634083-de6b-46cc-ad2e-15cc96a15c01",
                        ProductName = "Bread",
                        ProductPictureUrl = $"{hostname}/images/groceries/spelt-bread-2-1326657.jpg",
                        ProductAllergyInfo = "Gluten"
                    }
                };
            }
           
            return Task.FromResult(_catalogItems);
        }

       
        public Task RemoveAsync(string id)
        {
            throw new NotImplementedException();
        }

        public Task UpdateAsync(CatalogItem entity)
        {
            throw new NotImplementedException();
        }

        Task<List<CatalogItem>> IRepository<CatalogItem>.ListAsync(ISpecification<CatalogItem> specification)
        {
            throw new NotImplementedException();
        }
    }
}
