f1=addfile("../DATA/fnl_20131006_12_00.grib2","r")
t=f1->TMP_P0_L100_GLL0
hgt=f1->HGT_P0_L100_GLL0
u=f1->UGRD_P0_L100_GLL0
v=f1->VGRD_P0_L100_GLL0
levels=f1->lv_ISBL0
lat=f1->lat_0 
lon=f1->lon_0 

print(levels)

wks=gsn_open_wks("png","panel")
gsn_define_colormap(wks, "BlAqGrYeOrReVi200")

res=True
res@gsnDraw=False
res@gsnFrame=False
res@cnFillOn=True
;res@lbOrientation="Vertical"
res@lbLabelBarOn=False

res@mpMinLatF=10.0
res@mpMaxLatF=50.
res@mpMinLonF=100.
res@mpMaxLonF=150.

 res@cnLevelSelectionMode = "ManualLevels"
  res@cnMinLevelValF       = 200    ; Set contour levels to
  res@cnMaxLevelValF       = 300    ; the same for each plot.
  res@cnLevelSpacingF      = 5


   select_level=(/13,20,22,24/)
  plots = new(dimsizes(select_level),graphic)
  do i=0,dimsizes(select_level)-1
    levelindex=select_level(i)
    res@tiMainString = levels(levelindex)/100+"hPa"
    plots(i)         = gsn_csm_contour_map(wks,t(levelindex,:,:),res)
  end do


pres=True
pres@gsnMaximize=True
pres@gsnPanelLabelBar=True
pres@pmLabelBarWidthF=0.8
pres@txString="Temperature (K)"
pres@gsnPanelFigureStrings=(/"(a)","(b)","(c)","(d)"/)
pres@gsnPanelFigureStringsJust="TopLeft"

gsn_panel(wks, plots, (/2,2/), pres)