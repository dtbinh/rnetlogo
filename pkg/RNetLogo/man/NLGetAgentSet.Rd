\name{NLGetAgentSet}
\alias{NLGetAgentSet}
\title{
  Reports variable value(s) of one or more agent(s) as a data.frame (optional as a list or vector)
}
\description{
  \code{NLGetAgentSet} is an easy way to access variable value(s) of one or more agent(s) (in a sorted way) by specifying the name of the agent or the name of an agentset containing the agents. An agent is a turtle, breed, patch, or link. An agentset is a collection of agents. 
}
\usage{
NLGetAgentSet(agent.var, agentset, as.data.frame=TRUE, 
              agents.by.row=FALSE, as.vector=FALSE, nl.obj=NULL)
}
\arguments{
  \item{agent.var}{
  A string or vector/list of strings with the variable names of the agent(s).
}
  \item{agentset}{
  A string specifying the agent or agentset to be queried.
}
  \item{as.data.frame}{
  (optional) If \code{TRUE} (default) the function will return a data.frame with a column for each \code{agent.var} and a row for each agent. 
  The column names are taken from the names of the \code{agent.var} argument.
  If \code{FALSE} the function will return a list instead of a data.frame 
  (little bit faster when not using \code{agents.by.row=TRUE}). 
}
  \item{agents.by.row}{
  (optional) This argument has an effect only in combination with \cr 
  \code{as.data.frame=FALSE}, i.e. when a list is returned.  
  If \code{agents.by.row=FALSE} (default) the returned list contains one list element for each \code{agent.var}. Each list element contains a vector with the values of the different agents (\code{agentset}).
  If \code{agents.by.row=TRUE} the returned list contains one list element for each agent. Each list element contains a vector with the values of the different requested agent variables \cr
  (\code{agent.var}). Attention: \code{agents.by.row=TRUE} makes the function very slow, especially when many agents are requested.
} 
  \item{as.vector}{
  (optional) Set this argument to \code{TRUE} for getting the result as a simple vector in case of requesting only one agent variable.
  This is the fastest way to access one agent variable. It does not make sense to set this variable to \code{TRUE} together with \code{as.data.frame=TRUE}, 
  but \code{as.vector} is processed first and will win the race if you accidentally set \code{as.data.frame} to \code{TRUE} as well. 
  By default \code{as.vector} is \code{FALSE}.
} 
  \item{nl.obj}{
  (optional) A string identifying a reference to a NetLogo instance created with \code{\link{NLStart}}.
}
}
\details{
  It's possible to use all variables of an agent, which can be found in NetLogo's Agent Monitors.
  It isn't possible to get values from different types of agents (i.e. turtles, patches, links) with one
  call of \code{NLGetAgentSet}.
}
\value{
  Returns a data.frame (optional a list) with the variable value(s) of an agent/agents of an agentset. 
  One row for each agent and one column for each agent variable.
  The result is sorted in the same manner as using \code{sort agentset} in NetLogo, i.e. turtles are sorted by their \code{who} variable and patches from upper left to lower right.
}
\author{
  Jan C. Thiele <rnetlogo@gmx.de>
}
\seealso{
  \code{\link{NLReport}},
  \code{\link{NLGetPatches}},
  \code{\link{NLGetGraph}}
}
\examples{
\dontrun{
nl.path <- "C:/Program Files/NetLogo 5.3/app"
NLStart(nl.path)
# NLLoadModel(...)
NLCommand("create-turtles 10")

colors <- NLGetAgentSet(c("who","xcor","ycor","color"), 
                        "turtles with [who < 5]")
str(colors)
                        
# or as a list (slightly faster):
colors.list <- NLGetAgentSet(c("who","xcor","ycor","color"), 
                        "turtles with [who < 5]", as.data.frame=FALSE)
str(colors.list)
            
# or as a list with one list element for each agent
# (very slow!, not recommended especially for large agentsets)
colors.list2 <- NLGetAgentSet(c("who","xcor","ycor","color"), 
                        "turtles with [who < 5]", as.data.frame=FALSE, 
                        agents.by.row=TRUE)
str(colors.list2)
                        
# getting the ends of links is a little bit more tricky, because they store only the
# reference to the turtles and turtles cannot directly be requested. 
# A way to go is:
# create some links
NLCommand("ask turtles [ create-links-with n-of 2 other turtles ]")
link.test <- NLGetAgentSet(c("[who] of end1","[who] of end2"),"links")
str(link.test)
}
}
\keyword{interface}
\keyword{NLGetAgentSet}
\keyword{RNetLogo}
