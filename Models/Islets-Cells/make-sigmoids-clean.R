# cell parameters

par(cex=1.0)

ncell = 250
npoints = 50
x = seq(0, 20, length.out = npoints)
t = rnorm(ncell, 11, 4.0)

# threshold function :
active = function(y, n){sum(y > theta)/n}

gdrc = function(x,t,k){1/(1 + exp((t - x)/k))}

ran_k = 0
k0 = 1
#k0 = 2
if(!ran_k){
  k = rep(k0, ncell)
} else{
  k = rnorm(ncell,2,0.5)
}

k = abs(k)

# islet parameters

# making the islet distribution broader while leaving
# the scale factor the same as the cells doesn't work: broadens both
# avg Ca and % active

nislet = 50 # maybe make it much smaller than the number of cells?

tislet = rnorm(nislet, 11, 1.2)
#tislet = rnorm(nislet, 11, 0.4)
#tislet = rnorm(nislet, 11, 4.0)

k0.islet = 2.0
# k0.islet = 1.5
# k0.islet = 1.0

kislet = rep(k0.islet, nislet)

# threshold for considering to be active:
theta = 0.4

# graphical parameters

par(las=1)
par(cex=1.3)

# par(mfrow = c(1,2))

# make cells

dummy = numeric(ncell*npoints)

gmat = matrix(dummy, nrow=npoints)

t = sort(t)
k = sort(k)

for(i in 1:ncell){
  gmat[,i] = gdrc(x, t[i], k[i])
}



# plot selected cells

slimming = 5
matplot(x, gmat[,seq(0, ncell, by=slimming)], t='l', lty=1, col='gray48', 
        ylab = "Normalized Ca", xlab = "Glucose (mM)", main = paste(ncell/slimming, "Selected Cells of", ncell))

meancell = gdrc(x, mean(t), k0)

lines(x, meancell, lwd=2, col='black')

legend(0, 0.95, legend = c("cells", "mean cell"), lty=1, lwd=c(1,2), col=c('grey48','black'))



# make a batch of islets


dummy = numeric(nislet*npoints)

gmat.islet = matrix(dummy, nrow=npoints)

for(i in 1:nislet){
  gmat.islet[,i] = gdrc(x, tislet[i], kislet[i])
}

slimming = 2
matplot(x, gmat.islet[,seq(0, nislet, by=slimming)], t='l', lty=1, col='grey', 
        ylab = "Normalized Ca", xlab = "Glucose (mM)", main = paste(nislet/slimming, "Selected Islets of", nislet))

lines(x, gdrc(x, mean(tislet), mean(kislet)), col='black', lwd=2)

legend(0, 0.95, legend = c("islets", "mean islet"), lty=1, lwd=c(1,2), col=c('grey','black'))

# plot islets

title = paste("Averages of", nislet, "Islets, Threshold = ", theta)

avg.islet = rowMeans(gmat.islet)

pctactive.islet = apply(gmat.islet, 1, active, n=nislet)

# plot average Ca and Ca of average cell

plot(x, avg, t='l', col='black', xlab = "Glucose (mM)", ylab = "Normalized Ca")
lines(x, meancell)
legend(0,1, legend=c("Average Cell Ca", "Mean Cell"), col=c("black", "black"), lty=c(1,2))


# plot average islet Ca and Ca of average islet

meanislet = gdrc(x, mean(tislet), mean(kislet))

plot(x, avg.islet, t='l', col='red', xlab = "Glucose (mM)", ylab = "Normalized Ca")
lines(x, meanislet)
legend(0,1, legend=c("Average Islet Ca", "Mean Islet"), col=c("red", "black"), lty=1)


# plot average Ca for islets and cells

plot(x, 100*avg.islet, t='l', lwd=2, xlab = "Glucose (mM)", 
     ylab = "Percent of max calcium")

lines(x, 100*avg, col='black', lwd=2, lty=2)


legend(0, 100, legend=c("Avg Islet Ca", "Avg Cell Ca"), lwd=c(2,2), lty=c(1,2), 
       col = c("black", "black"))

# plot % responding islets and cells

plot(x, 100*pctactive.islet, t='l', lwd=2, xlab = "Glucose (mM)", 
     ylab = "Percent Responding", col='black')

lines(x, 100*pctactive, col='black', lwd=2, lty=2)

legend(0, 100, legend=c("% islets active", "% cells active"), 
       col = c("black","black"), lty=c(1,2), lwd=c(2,2), cex=1 )
