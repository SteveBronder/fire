instrument_all = new.env()

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
                        dep_sub = function(x) deparse(substitute(x)),
                        addCurrency = function(primary_id, ...) {
                          self$currencies <- c(self$currencies,
                                               currency$new(primary_id, ...))
                          names(self$currencies) <- unlist(lapply(self$currencies,
                                                                function(x) x$primary_id))
                        },
                        getCurrency = function(primary_id) {
                          return(self$currencies[[self$dep_sub(primary_id)]])
                        },
                        addStock = function(primary_id, currency, ...){
                          currency = self$getCurrency(currency)
                          self$stocks <- c(self$stocks,
                                          stock$new(primary_id, currency, ...)
                                          )
                          names(self$stocks) <- unlist(
                            lapply(self$stocks, function(x) x$primary_id)
                            )
                        },
                        getStock = function(primary_id) {
                          return(self$stock[[self$dep_sub(primary_id)]])
                        }
                      ),
                      parent_env = instrument_all
                      )

#' constructor for spot exchange rate instruments
#'
#' Currency symbols (like any symbol) may be any combination of alphanumeric
#' characters, but the FX market has a convention that says that the first
#' currency in a currency pair is the 'target'  and the second currency in the
#' symbol pair is the currency the rate ticks in.  So 'EURUSD' can be read as
#' 'USD per 1 EUR'.
#'
#' In \code{FinancialInstrument} the \code{currency} of the instrument should
#' be the currency that the spot rate ticks in, so it will typically be the
#' second currency listed in the symbol.
#'
#' Thanks to Garrett See for helping sort out the inconsistencies in different
#' naming and calculating conventions.
#' @param primary_id string identifier, usually expressed as a currency pair
#'   'USDYEN' or 'EURGBP'
#' @param currency string identifying the currency the exchange rate ticks in
#' @param counter_currency string identifying the currency which the rate uses
#'   as the base 'per 1' multiplier
#' @param tick_size minimum price change
#' @param identifiers named list of any other identifiers that should also be
#'   stored for this instrument
#' @param assign_i TRUE/FALSE. Should the instrument be assigned in the
#'   \code{.instrument} environment? (Default TRUE)
#' @param overwrite \code{TRUE} by default.  If \code{FALSE}, an error will
#'   be thrown if there is already an instrument defined with the same
#'   \code{primary_id}.
#' @param ... any other passthru parameters
#' @references http://financial-dictionary.thefreedictionary.com/Base+Currency
#' @export
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
                       self$primary_id = deparse(substitute(primary_id))
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
                   parent_env = instrument_all
)

#' @export
#' @rdname instrument
stock = R6Class("stock",
                   lock_objects = FALSE,
                   public = list(
                     primary_id = NULL,
                     identifiers = NULL,
                     multiplier = 1,
                     tick_size = .01,
                     currency = currency$new(USD),
                     initialize = function(primary_id, identifiers = NULL,
                                           multiplier = 1, tick_size = .01,
                                           type = NULL,
                                           currency = NULL,
                                           ...) {
                       self$primary_id = deparse(substitute(primary_id))
                       self$identifiers = identifiers
                       self$multiplier = multiplier
                       self$tick_size = tick_size
                       self$type = type
                       self$currency = currency
                       extra = list(...)
                       extra_names = names(extra)
                       for (i in seq_len(length((extra_names)))){
                         self[[extra_names[i]]] <- extra[[i]]
                       }
                     }
                   ),
                   parent_env = instrument_all
)

# TODO: Add currency to stock
# https://github.com/braverock/FinancialInstrument/blob/master/R/instrument.R
