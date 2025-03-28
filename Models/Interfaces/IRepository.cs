﻿using System.Linq.Expressions;
using System.Net.NetworkInformation;

namespace JustLearn1.Repository.IRepository
{
    public interface IRepository<T> where T : class
    {
        //T - category
        IEnumerable<T> GetAll(Expression<Func<T, bool>>? filter = null, string? includeProperties = null);
        T Get(Expression<Func<T, bool>> filter, string? includeProperties = null);
        void Add(T entity);
        void Remove(T entity);
        void RemoveRange(IEnumerable<T> entity);

    }
}
