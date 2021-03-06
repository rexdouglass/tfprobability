% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/distribution-methods.R
\name{tfd_survival_function}
\alias{tfd_survival_function}
\title{Survival function.}
\usage{
tfd_survival_function(distribution, value, ...)
}
\arguments{
\item{distribution}{The distribution being used.}

\item{value}{float or double Tensor.}

\item{...}{Additional parameters passed to Python.}
}
\value{
a Tensor of shape \code{sample_shape(x) + self$batch_shape} with values of type \code{self$dtype}.
}
\description{
Given random variable X, the survival function is defined:
\code{tfd_survival_function(x) = P[X > x] = 1 - P[X <= x] = 1 - cdf(x)}.
}
\examples{
\donttest{
  d <- tfd_normal(loc = c(1, 2), scale = c(1, 0.5))
  x <- d \%>\% tfd_sample()
  d \%>\% tfd_survival_function(x)
}
}
\seealso{
Other distribution_methods: \code{\link{tfd_cdf}},
  \code{\link{tfd_covariance}},
  \code{\link{tfd_cross_entropy}},
  \code{\link{tfd_entropy}},
  \code{\link{tfd_kl_divergence}},
  \code{\link{tfd_log_cdf}}, \code{\link{tfd_log_prob}},
  \code{\link{tfd_log_survival_function}},
  \code{\link{tfd_mean}}, \code{\link{tfd_mode}},
  \code{\link{tfd_prob}}, \code{\link{tfd_quantile}},
  \code{\link{tfd_sample}}, \code{\link{tfd_stddev}},
  \code{\link{tfd_variance}}
}
\concept{distribution_methods}
