using CnAppForAzureDev.Entities;
using System;
using System.Linq.Expressions;

namespace CnAppForAzureDev.Repositories.Specifications
{
    public class SpecificationBase<TEntity> : ISpecification<TEntity>
       where TEntity : EntityBase
    {
        protected SpecificationBase(Expression<Func<TEntity, bool>> criteria)
        {
            Criteria = criteria ?? throw new ArgumentNullException(nameof(criteria));
        }

        public Expression<Func<TEntity, bool>> Criteria { get; }

        Expression<Func<TEntity, bool>> ISpecification<TEntity>.Criteria => throw new NotImplementedException();
    }
}