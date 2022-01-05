list(
  map_ = function(f) function(a) function() f(a()),
  pure_ = function(a) function() a,
  bind_ = function(a) function(f) function() f(a())(),
  run = function(f) f(),
  `while` = function(f) function(a) function() while (f()) a(),
  `for` = function(lo) function(hi) function(f) function() for (i in lo:(hi - 1)) f(i)(),
  foreach = function(as) function(f) function() for (i in seq(along = as)) f(as[[i]])(),
  new = function(val) function() list(value = val),
  read = function(ref) function() ref$value,
  modifyImpl = function(f) {
    function(ref) {
      function() {
        t <- f(ref$value)
        ref$value <- t$state
        t$value
      }
    }
  },
  write = function(a) function(ref) function() ref$value <- a
)
