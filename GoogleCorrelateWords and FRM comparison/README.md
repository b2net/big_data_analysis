## bestglm_lambda_down

 ![bestglm_lambda_down1.png](bestglm_lambda_down1.png)
 ![bestglm_lambda_down2.png](bestglm_lambda_down2.png)
 ![bestglm_lambda_down3.png](bestglm_lambda_down3.png)
 
```R
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("bestglm")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
Lambda_mean = read.csv("Lambda_Zeitreihe_Mai15_weekly.csv", header = TRUE, sep = ";", dec = ",")
ctest = read.csv("Google_Correlate_with_downturn.csv", header = TRUE, sep = ";", dec = ",")


# Plot 1: Financial Risk Meter
plot(Lambda_mean[, 2], type = "l", pch = 1, col = "red", xaxt = "n", xlab = "Date", 
    ylab = "Lambda", main = "Financial Risk Meter", ylim = c(0, 0.15), lwd = 2)
axis(1, at = c(1:nrow(Lambda_mean)), labels = Lambda_mean[, 1])

# 100 most correlated words with the term "downturn" from Google Trends
colnames(ctest)

# Erase / Deselect suspicious predictor variables
ctest_clean = subset(ctest, select = -c(acai, acai.berry, banorte.mexico, blow.ya.back.out, 
    X18.days.lyrics, motor.arcade, unknown, motorbike.games, te.regalo.amores.lyrics, 
    break.me.down.if.it.makes.you.feel.right, matlab.2008b, notepad.2008, lions.tigers.and.bears.lyrics, 
    unknown.1, vmware.server.2, saving.abel.18.days.lyrics, seether.breakdown.lyrics, 
    el.angel, rolling.turtle, killers.spaceman, eclipse.3.4.1, she.got.her.own, song.love.story, 
    hottest.only, got.her.own, filezilla.free, the.killers.spaceman, que.quede.claro, 
    netbeans.6.5, smallville.season.8.episode.guide, samsung.sway, acai.berry.reviews, 
    luna.eddy.lover, y.que.quede.claro, uphill.rush.game, founding.farmers.restaurant, 
    gorilla.zoe.lost, jeremy.camp.there.will.be.a.day, filezilla.free.download, casting.crowns.slow.fade, 
    thesaurus.free, my.story.by.sean.mcgee, cuidado.con.el.angel, ron.browz, uyg, 
    seether.breakdown, slow.fade, slow.fade.lyrics, smoking.my.cancer, economy.jokes, 
    lost.gorilla.zoe, framing.hanley.lollipop, pbwiki.login, tan.her.hide, slam.crunk, 
    socialvibe, alternext, gdp.2008, us.gdp.2008, mil.demonios, lost.by.gorilla.zoe, 
    synthasite.com, saving.abel.18.days), drop = TRUE)

# bestGLM Regression: Google Trends terms on the lambda time series of the Financial Risk Meter
regsub = regsubsets(x = ctest_clean[184:584, c(2:10)], y = Lambda_mean[1:401, 2], 
    nvmax = 4)
summary(regsub)
# Adjusted R-squared
summary(regsub)$adjr2

# Alternative quality criteria - BIC criteria. The smaller the value the better is the variable/model.
# Plot 2:
dev.new()
#Summary-plot for choosing a Model
#The darker a rectangle, the higher is the probability, that the variable is included in the model (ordered by the BIC criterion).
#The columns (x-axis) show the possible variables for the model with respect to the BIP criterion.
#For example: The best model would include 4 variables "bad economy", "down economy" "tough economic times" and "recession proof".
#This heatmap plot makes sense for better interpretation if the summary(.) output is too large.
#This may be the case, if more than 15 predictors are used for model selection.

plot(regsub, main = "Heatmap of the BIC criterion depending on selected variables for the regression")
summary(regsub)$bic
summary(regsub, all.best = TRUE, matrix = TRUE, matrix.logical = FALSE, df = NULL)

# Compare with Linear Regression Model down.economy -- FRM shifted 5 weeks
# backwards = down.economy shifted 5 weeks forwards (-5)
lm_down_eco = lm(Lambda_mean[1:401, 2] ~ ctest_clean[179:579, "down.economy"])
summary(lm_down_eco)

# Plot 3: Regression: down.economy -- FRM shifted 5 weeks
dev.new()
plot(Lambda_mean[1:401, 2] ~ ctest_clean[181:581, "down.economy"],
    main = "Scatter plot between the search term „down economy“ and the time series of the Financial Risk Meter", 
    ylab = "Lambda time series (FRM)", xlab = "search term: 'down economy'")
abline(lm_down_eco, col = "red") 
 
```
