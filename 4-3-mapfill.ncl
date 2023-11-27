
tf=addfile("../DATA/meccatemp.cdf", "r")

T=tf->t(0,:,:)
printVarSummary(T)
printVarSummary(T&lon)

wks=gsn_open_wks("x11", "contour2a")
;gsn_define_colormap(wks,"wh-bl-gr-ye-re")

res=True

res@gsnSpreadColorStart = 14 ;颜色表索引
res@pmTickMarkDisplayMode = "Always" ; tickmark刻度线

res@cnFillOn           = True

res@cnLevelSelectionMode="ManualLevels"
res@cnMinLevelValF      =195
res@cnMaxLevelValF      =328
res@cnLevelSpacingF     =2.25
res@cnLinesOn          = False

res@lbBoxLinesOn       = False


; res@mpFillOn   = True
; res@mpLandFillColor = "grey";164
; ; res@mpOceanFillColor= 90
; res@mpInlandWaterFillColor=54
; res@mpOutlineOn=True
; res@cnFillDrawOrder   = "PreDraw"

plot=gsn_csm_contour_map(wks, T, res)
