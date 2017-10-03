instruments = R6Class("instruments",
                      lock_objects = FALSE,
                      public = list(
                        bonds = list(),
                        currencies = list(),
                        futures = list(),
                        options = list(),
                        stocks = list(),
                        initialize = function(bonds = list(), currencies = list(),
                                              futures = list(), options = list(),
                                              stocks = list()) {
                          self$bonds = bonds
                          self$currencies = currencies
                          self$futures = futures
                          self$options = options
                          self$stocks = stocks
                        },
                        addCurrency = function(...) {
                          self$currencies <- c(self$currencies, currency$new(...))
                          names(self$currencies) <- unlist(lapply(self$currencies,
                                                                function(x) x$primary_id))
                        },
                        getCurrency = function(primary_id) {
                          return(self$currencies[[deparse(substitute(primary_id))]])
                        },
                        addStock = function(...){
                          self$stock <- c(self$stock, stock$new(...))
                          names(self$stock) <- unlist(lapply(self$stock,
                                                                  function(x) x$primary_id))
                        },
                        getStock = function(primary_id) {
                          return(self$stock[[deparse(substitute(primary_id))]])
                        }
                      )
                      )

currency = R6Class("currency",
                   lock_objects = FALSE,
                   public = list(
                     primary_id = NULL,
                     identifiers = NULL,
                     multiplier = 1,
                     tick_size = .01,
                     initialize = function(primary_id, identifiers = NULL,
                                           multiplier = 1, tick_size = .01,
                                           type = NULL, ...) {
                       self$primary_id = primary_id
                       self$identifiers = identifiers
                       self$multiplier = multiplier
                       self$tick_size = tick_size
                       self$type = type
                       extra = list(...)
                       extra_names = names(extra)
                       for (i in seq_len(length((extra_names)))){
                         self[[extra_names[i]]] <- extra[[i]]
                       }
                     }
                   ),
                   parent_env = instruments
)

stock = R6Class("stock",
                   lock_objects = FALSE,
                   public = list(
                     primary_id = NULL,
                     identifiers = NULL,
                     multiplier = 1,
                     tick_size = .01,
                     initialize = function(primary_id, identifiers = NULL,
                                           multiplier = 1, tick_size = .01,
                                           type = NULL, ...) {
                       self$primary_id = primary_id
                       self$identifiers = identifiers
                       self$multiplier = multiplier
                       self$tick_size = tick_size
                       self$type = type
                       extra = list(...)
                       extra_names = names(extra)
                       for (i in seq_len(length((extra_names)))){
                         self[[extra_names[i]]] <- extra[[i]]
                       }
                     }
                   ),
                   parent_env = instruments
)

# TODO: Add currency to stock
# https://github.com/braverock/FinancialInstrument/blob/master/R/instrument.R
