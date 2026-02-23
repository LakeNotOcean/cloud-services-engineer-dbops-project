# dbops-project
Репозиторий для выполнения проекта дисциплины "DBOps"


# Настройка БД

Для успещного применения миграций необходимо:

1. Создать БД:
    ```
    CREATE DATABSE <DB_NAME>;
    ```
2. Создать пользователя БД для применения миграций и прохождения автотестов:
    ```
    CREATE ROLE <DB_USER> WITH LOGIN PASSWORD '<DB_PASSWORD>';
    ```
3. Выдать доступ ко всем привелегиям сервисному пользователю миграции:
    ```
    GRANT ALL PRIVILEGES ON DATABASE <DB_NAME> TO <DB_USER>;
    -- Предварительно требуется подключиться к БД к <DB_NAME>
    GRANT USAGE, CREATE ON SCHEMA public TO <DB_USER>;
    ```

# Сравнение времени выполнения запроса до и после создания индексов

### Используемый запрос
```sql
SELECT 
    o.date_created, 
    SUM(op.quantity)
FROM 
    orders o
JOIN 
    order_product op 
    ON 
    o.id = op.order_id
WHERE 
    o.status = 'shipped' 
    AND 
    o.date_created > NOW() - INTERVAL '7 DAY'
GROUP BY 
    o.date_created;  
```

### Выполнение запроса до создания индексов

Время выполнения: 40538.136 ms (00:40.538)

План выполнения запроса:
```
                                                              QUERY PLAN
--------------------------------------------------------------------------------------------------------------------------------------
 Finalize GroupAggregate  (cost=266020.45..266043.50 rows=91 width=12)
   Group Key: o.date_created
   ->  Gather Merge  (cost=266020.45..266041.68 rows=182 width=12)
         Workers Planned: 2
         ->  Sort  (cost=265020.43..265020.65 rows=91 width=12)
               Sort Key: o.date_created
               ->  Partial HashAggregate  (cost=265016.55..265017.46 rows=91 width=12)
                     Group Key: o.date_created
                     ->  Parallel Hash Join  (cost=148234.64..264534.41 rows=96428 width=8)
                           Hash Cond: (op.order_id = o.id)
                           ->  Parallel Seq Scan on order_product op  (cost=0.00..105362.15 rows=4166715 width=12)
                           ->  Parallel Hash  (cost=147029.29..147029.29 rows=96428 width=12)
                                 ->  Parallel Seq Scan on orders o  (cost=0.00..147029.29 rows=96428 width=12)
                                       Filter: (((status)::text = 'shipped'::text) AND (date_created > (now() - '7 days'::interval)))
 JIT:
   Functions: 18
   Options: Inlining false, Optimization false, Expressions true, Deforming true
(17 rows)
```

### Выполнение запроса после добавления индексов

Время выполнения: 

План выполнения:
```
```

