library(season)

year = c(rep(2017,8),rep(2018,4))
month = c(5,6,7,8,9,10,11,12,1,2,3,4)
rain = c(131,178,266,263,424,334,259,0,0,24,122,501)
data = data.frame(year,month,rain)
cycles = 12
tau = c(10,100)

out = nscosinor(data, response='rain', cycles, tau = tau)
summary(out)

plot(rain)
lines(out$fitted.values$mean,lty=1)
lines(out$fitted.values$lower,lty=2)
lines(out$fitted.values$upper,lty=2)

plot(out)
plot.nsCosinor(out)
seasrescheck(out$residuals)

