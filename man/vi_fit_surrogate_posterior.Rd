% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vi-optimization.R
\name{vi_fit_surrogate_posterior}
\alias{vi_fit_surrogate_posterior}
\title{Fit a surrogate posterior to a target (unnormalized) log density}
\usage{
vi_fit_surrogate_posterior(target_log_prob_fn, surrogate_posterior,
  optimizer, num_steps, trace_fn = function(loss, grads, variables) loss,
  variational_loss_fn = NULL, sample_size = 1,
  trainable_variables = NULL, seed = NULL,
  name = "fit_surrogate_posterior")
}
\arguments{
\item{target_log_prob_fn}{function that takes a set of \code{Tensor} arguments
and returns a \code{Tensor} log-density. Given
\code{q_sample <- surrogate_posterior$sample(sample_size)}, this
will be (in Python) called as \code{target_log_prob_fn(q_sample)} if \code{q_sample} is a list
or a tuple, \code{target_log_prob_fn(**q_sample)} if \code{q_sample} is a
dictionary, or \code{target_log_prob_fn(q_sample)} if \code{q_sample} is a \code{Tensor}.
It should support batched evaluation, i.e., should return a result of
shape \code{[sample_size]}.}

\item{surrogate_posterior}{A \code{tfp$distributions$Distribution}
instance defining a variational posterior (could be a
\code{tfp$distributions$JointDistribution}). Crucially, the distribution's \code{log_prob} and
(if reparameterized) \code{sample} methods must directly invoke all ops
that generate gradients to the underlying variables. One way to ensure
this is to use \code{tfp$util$DeferredTensor} to represent any parameters
defined as transformations of unconstrained variables, so that the
transformations execute at runtime instead of at distribution creation.}

\item{optimizer}{Optimizer instance to use. This may be a TF1-style
\code{tf$train$Optimizer}, TF2-style \code{tf$optimizers$Optimizer}, or any Python-compatible
object that implements \code{optimizer$apply_gradients(grads_and_vars)}.}

\item{num_steps}{\code{integer} number of steps to run the optimizer.}

\item{trace_fn}{function with signature \code{state = trace_fn(loss, grads, variables)},
where \code{state} may be a \code{Tensor} or nested structure of \code{Tensor}s.
The state values are accumulated (by \code{tf$scan})
and returned. The default \code{trace_fn} simply returns the loss, but in
general can depend on the gradients and variables (if
\code{trainable_variables} is not \code{NULL} then \code{variables==trainable_variables};
otherwise it is the list of all variables accessed during execution of
\code{loss_fn()}), as well as any other quantities captured in the closure of
\code{trace_fn}, for example, statistics of a variational distribution.
Default value: \code{function(loss, grads, variables) loss}.}

\item{variational_loss_fn}{function with signature
\code{loss <- variational_loss_fn(target_log_prob_fn, surrogate_posterior, sample_size, seed)}
defining a variational loss function. The default is
a Monte Carlo approximation to the standard evidence lower bound (ELBO),
equivalent to minimizing the 'reverse' \code{KL[q||p]} divergence between the
surrogate \code{q} and true posterior \code{p}.
Default value: \code{functools.partial(tfp.vi.monte_carlo_variational_loss, discrepancy_fn=tfp.vi.kl_reverse, use_reparameterization=True)}.}

\item{sample_size}{\code{integer} number of Monte Carlo samples to use
in estimating the variational divergence. Larger values may stabilize
the optimization, but at higher cost per step in time and memory.
Default value: \code{1}.}

\item{trainable_variables}{Optional list of \code{tf$Variable} instances to optimize
with respect to. If \code{NULL}, defaults to the set of all variables accessed
during the computation of the variational bound, i.e., those defining
\code{surrogate_posterior} and the model \code{target_log_prob_fn}. Default value: \code{NULL}.}

\item{seed}{integer to seed the random number generator.}

\item{name}{name prefixed to ops created by this function. Default value: 'fit_surrogate_posterior'.}
}
\value{
results \code{Tensor} or nested structure of \code{Tensor}s, according to the
return type of \code{result_fn}. Each \code{Tensor} has an added leading dimension
of size \code{num_steps}, packing the trajectory of the result over the course of the optimization.
}
\description{
The default behavior constructs and minimizes the negative variational
evidence lower bound (ELBO), given by\preformatted{q_samples <- surrogate_posterior$sample(num_draws)
elbo_loss <- -tf$reduce_mean(target_log_prob_fn(q_samples) - surrogate_posterior$log_prob(q_samples))
}
}
\details{
This corresponds to minimizing the 'reverse' Kullback-Liebler divergence
(\code{KL[q||p]}) between the variational distribution and the unnormalized
\code{target_log_prob_fn}, and  defines a lower bound on the marginal log
likelihood, \code{log p(x) >= -elbo_loss}.

More generally, this function supports fitting variational distributions that
minimize any \href{https://en.wikipedia.org/wiki/F-divergence}{Csiszar f-divergence}.
}
\seealso{
Other vi-functions: \code{\link{vi_amari_alpha}},
  \code{\link{vi_arithmetic_geometric}},
  \code{\link{vi_chi_square}},
  \code{\link{vi_csiszar_vimco}},
  \code{\link{vi_dual_csiszar_function}},
  \code{\link{vi_jeffreys}},
  \code{\link{vi_jensen_shannon}},
  \code{\link{vi_kl_forward}}, \code{\link{vi_kl_reverse}},
  \code{\link{vi_log1p_abs}},
  \code{\link{vi_modified_gan}},
  \code{\link{vi_monte_carlo_variational_loss}},
  \code{\link{vi_pearson}},
  \code{\link{vi_squared_hellinger}},
  \code{\link{vi_symmetrized_csiszar_function}}
}
\concept{vi-functions}
