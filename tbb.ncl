f=asciiread("../DATA/tbb_plot1.data",-1, "string")
tbbmin=tofloat(str_get_field(f, 1, " "))
;print(tbbmin)
area=tofloat(str_get_field(f, 2, " "))
hr=(/8,9,10,11,12,13,14,15,16,17/)

wks=gsn_open_wks("png", "TBB")

res=True
res@tmXTOn=False
res@trXMinF=min(hr)-1
res@trXMaxF=max(hr)+1
res@tmXBMode="Explicit"
res@tmXBValues=(/7,8,9,10,11,12,13,14,15,16,17,18/)
res@tmXBLabels=(/"7:00","8:00","9:00","10:00","11:00","12:00",\
                "13:00","14:00","15:00","16:00","17:00","18:00"/)
res@tmXBLabelFontHeightF=0.012

;res@tmXMajorGrid = True
;res@tmXMajorGridThicknessF       = 2.
;res@tmXMajorGridLineColor        = "grey"
;res@tmXMajorGridLineDashPattern  = 15 

res@tiXAxisString="hour"

;---------------------------

res1=res
res1@xyLineThicknesses=5
res1@xyLineColors="orange"
res1@xyMarkLineMode="MarkLines"       ;设置显示结点
res1@xyMarkerColor="orange"            ;设置节点颜色
res1@xyMarkerSizes= 0.03              ;设置节点大小
res1@xyMarker     = 1                 ;设置节点类型 默认为0                                              
res1@tmYLMode="Explicit"
res1@tmYLValues=ispan(220, 240, 5)
res1@tmYLLabels=(/"220K","225K","230K","235K","240K"/)
res1@trYMinF=220
res1@trYMaxF=240
res1@tiYAxisString="TBB"
res1@tiYAxisFontColor="orange"

;res1@tmYMajorGrid = True
;res1@tmYMajorGridThicknessF       = 2.
;res1@tmYMajorGridLineColor        = "grey"
;res1@tmYMajorGridLineDashPattern  = 15 

;-------------------------

res2=res
res2@gsnXYBarChart=True
res2@xyLineColors="brown"
res2@xyLineThicknesses=3
res2@xyLineOpacities=0.2
res2@gsnXYBarChartColors="BrownBlue12"          ;填充颜色
res2@gsnXYBarChartFillOpacityF=0.2
res2@gsnXYBarChartBarWidth=1
res2@tmYROn=True
res2@tmYRMode="Explicit"
res2@tmYRValues=ispan(0, 250, 50)
res2@tmYRLabels=res2@tmYRValues
;res2@tmYRMode="Manual"
;res2@tmYRTickStartF=0
;res2@tmYRTickEndF=240
;res2@tmYRTickSpacingF=40
res2@trYMinF=0
res2@trYMaxF=250
res2@tiYAxisString="Area(TBB<241)"
res2@tiYAxisFontColor="brown"

plot=gsn_csm_xy2(wks, hr, tbbmin(2:11), area(2:11), res1, res2)