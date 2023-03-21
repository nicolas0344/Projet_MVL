library(MASS)
library(ggplot2)


dt_param = data.frame(mixtureParameters = c("parameters of Mixture1",
                                           "parameters of Mixture2"),
                            alpha = c(0.4,0.6), mean = c(50, 220),
                            sd = c(11, 50))

# Cette fonction génère aléatoirement un échantillon de taille n issu 
# d'un mélange gaussien
# Elle prend en argument dt_param et n
# dt_param est le dataframe contenant les paramètres alpha, mu et sigma
# n indique la taille de l'échantillon
# Elle retourne un vecteur de taille n
# Il s'agit de l'échantillon du vecteur gaussien
simulation = function(dt_param, n=100){
  X = rep(NA,n) #echantillon
  vect_alpha = dt_param[,2]
  vect_mean = dt_param[,3]
  vect_sd = dt_param[,4]
  for(i in 1:n){
    Z = runif(1)
    if (Z <= vect_alpha[1]){
      X[i] = rnorm(1, vect_mean[1], vect_sd[1])
    }else{
      k = 1
      l = 2
      Bool = FALSE
      cumul_alpha = cumsum(vect_alpha)
      while(Bool == FALSE){
        if((cumul_alpha[k]<=Z) & (cumul_alpha[l]>=Z)){
          Bool = TRUE
          param_index = l
        }
        k = k+1
        l = l+1
      }
      X[i] = rnorm(1, vect_mean[param_index], vect_sd[param_index])
    }
  }
  return(X)
}


plot_distrib = function(df, X){
  data_distrib = data.frame(gaussian_mixture = X)
  ggplot(data_distrib, aes(x=data_distrib[,'gaussian_mixture'])) + 
  geom_histogram(aes(y=..density..), colour="black", fill="white", bins = 30) +
  geom_density(alpha=.5, color = "green", fill="orange", size=1.2) + 
  ggtitle("Distribution du mélange gaussien") + xlab("")
}

plot_distrib(dt_param, samp)

# Fonction générant dataframe (vide)
# contenant les valeurs de P_thetat(j|X = X_i) (etape E de l'algo)
# Cette fonction prend en argument n (la taille de l'échantillon)
# Et J le nombre de mélange
param_State_E = function(n, J){
  data_stateE = data.frame(matrix(NA, nrow = n, ncol = J))
  for(j in 1:J){
    names(data_stateE)[j] = paste("H(.,",j,")",sep="")
  }
  return(data_stateE)
}

# Cette fonction est une implémentation de l'algorithme EM
# Elle prend en argument
# dt_init: dataframe contenant les paramètres (alpha, mu, sigma)
# initiaux choisis
# X: vecteur jouant le role de l'échantillon de taille n
# K: nombre d'itérations souhaitées de l'algorithme EM
# Cette fonction retourne un dataframe contenant les valeurs des
# paramètres alpha, mu et sigma estimées

algo_EM = function(dt_init, X, K){
  J = dim(dt_init)[1]
  n = length(X)
  data_stateE = param_State_E(n, J)
  
  for(k in 1:K){
    vect_alpha = dt_init[,2] #de longueur J
    vect_mean = dt_init[,3]
    vect_sd = dt_init[,4]
    # vecteur contenant la somme des des numérateurs de P_thetat(j|X = X_i)
    # pour chaque valeur de l’échantillon 
    v = rep(0,n) 
    
    # Etape E
    for(j in 1:J){
      # On remplie le tableau param_State_E contenant P_thetat(j|X=X_i)
      data_stateE[,j] = vect_alpha[j]*dnorm(X,vect_mean[j],vect_sd[j])
      v = v+data_stateE[,j]
    }
    for(j in 1:J){
      data_stateE[,j] = data_stateE[,j]/v
    }
    
    # Etape M
    H = data_stateE
    for(col in 2:4){ #on met a jour le dt_init
      for(ind in 1:J){
        
        # on met à jour les alpha
        if(col == 2){
          dt_init[,col][ind] = mean(H[,ind])
        }
        # on met à jour les mu
        if(col == 3){
          dt_init[,col][ind] = (sum(X*H[,ind]))/(sum(H[,ind]))
        } 
        # on met à jour les sigma
        if(col == 4){
          dt_init[,col][ind] = sqrt((sum( (X-rep(dt_init[,col-1][ind],n))^2
                                            *H[,ind] ))/sum(H[,ind]))
        }
      }
    }
  }
  new_df = dt_init
  colnames(new_df) = c('mixtureParameters', 'alpha', 'mu', 'sigma')
  return(new_df)
}

dt_init = data.frame(mixtureParameters = c("parameters of Mixture1",
                                           "parameters of Mixture2"),
                            alpha_init = c(0.2,0.8), mean_init = c(30, 280),
                            sd_init = c(21, 160))

dt_param2 = data.frame(mixtureParameters = c("parameters of Mixture1",
                                            "parameters of Mixture2"),
                      alpha = c(0.3, 0.33, 0.15, 0.22),
                      mean = c(35, 350, 720,1198),
                      sd = c(11, 22, 32, 55))

dt_init2 = data.frame(mixtureParameters = c("parameters of Mixture1",
                                           "parameters of Mixture2"),
                     alpha_init = c(0.33, 0.3, 0.17, 0.2),
                     mean_init = c(10, 30, 280, 410),
                     sd_init = c(10, 25, 30, 57))

samp2 = simulation(dt_param2, 1000)
plot_distrib(dt_init2, samp2)

# data(galaxies)
# X = galaxies/1000
# d = density(X, kernel = 'gaussian')
# plot(d, lwd = 2, main = 'test')