PlotResultsOnMap_Fn <-
function(MappingDetails, Report, PlotDF, MapSizeRatio, Xlim, Ylim, FileName, Year_Set=NULL, Years2Include=NULL,
         Rescale=FALSE, Rotate=0, Format="png", Res=200, ...){

  # Fill in missing inputs
  if( is.null(Year_Set) ) Year_Set = 1:ncol(Report$D_xt)
  if( is.null(Years2Include) ) Years2Include = 1:ncol(Report$D_xt)
  # Extract elements
  attach( Report )
  on.exit( detach(Report) )
  plot_codes <- c("Pres","Pos","Dens","Pos_Rescaled","Dens_Rescaled","Eps_Pres","Eps_Pos")

  # Loop through plots
  for(RespI in 1:7){
    if(RespI==1){
      # Presence/absence ("Pres")
      Mat = R1_xt 
    }
    if(RespI==2){
      # Positive values ("Pos")
      Mat = log(R2_xt+quantile(R2_xt,0.01))
      Mat = ifelse(Mat<(-5),-5,Mat)
    }
    if(RespI==3){
      # Density ("Dens")
      Mat = log(D_xt+quantile(D_xt,0.01))
      Mat = ifelse(Mat<(-5),-5,Mat)
    }
    if(RespI==4){
      # Positive values rescaled ("Pos_Rescaled")
      Mat = log(R2_xt+quantile(R2_xt,0.25))
    }
    if(RespI==5){
      # Density rescaled ("Dens_Rescaled")
      Mat = log(D_xt+quantile(D_xt,0.25))
    }
    if(RespI==6){
      # Epsilon for presence/absence ("Eps_Pres")
      Mat = Epsilon1_st # maybe should be exponentiated?
    }
    if(RespI==7){
      # Epsilon for positive values ("Eps_Pos")
      Mat = Epsilon2_st # maybe should be exponentiated?
    }
    # Do plot
    PlotMap_Fn( MappingDetails=MappingDetails, Mat=Mat[,Years2Include], PlotDF=PlotDF, MapSizeRatio=MapSizeRatio, Xlim=Xlim, Ylim=Ylim, FileName=paste0(FileName,plot_codes[RespI]), Year_Set=Year_Set[Years2Include], Rescale=Rescale, Rotate=Rotate, Format=Format, Res=Res, ...)
  }
}
