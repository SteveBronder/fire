# fire

You can do stuff like this now

```r
test = instruments$new()
test$addCurrency(primary_id = USD, multipler = .3, foo = "blarney")
test$addCurrency(primary_id = EUR, multipler = 1.3, foo = "baloney")
test$getCurrency(primary_id = EUR)
test$addStock(primary_id = ETX, currency = USD)
test$getStock(ETX)
<stock>
#  Public:
#    clone: function (deep = FALSE) 
#    currency: NULL #whoops!
#    identifiers: currency, R6
#    initialize: function (primary_id, identifiers = NULL, multiplier = 1, tick_size = 0.01, 
#    multiplier: 1
#    primary_id: primary_id
#    tick_size: 0.01
#    type: NULL
```
