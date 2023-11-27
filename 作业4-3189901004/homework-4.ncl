f=asciiread("../DATA/TBB_plot.data", -1, "string")
str=f(1:)
hr=str_get_field(str, 1, " ") ;06~20 字符串
;hr=ispan(6,20,1)
data1= tofloat(str_get_field(str, 2, " ")) 
data2= tofloat(str_get_field(str, 3, " ")) 
wks=gsn_open_wks("png", "homework-4")

res=True

res@tmXTOn=False
res@tmXBMode="Explicit"
res@tmXBValues=toint(hr)
res@tmXBLabels=hr+"Z"
;(/"","06Z","07Z","08Z","09Z","10Z","11Z",\
                ;"12Z","13Z","14Z","15Z","16Z","17Z","18Z","19Z","20Z",""/)
res@tmXBLabelAngleF=-60
res@tmXBLabelFontHeightF=0.012
res@trXMinF=5
res@trXMaxF=21

res@tiXAxisString="hour"
res@tiMainString="TBB"

;---------------------------

res1=res
res1@xyLineThicknesses=4
res1@xyLineColors="GreenYellow"
res1@xyMarkLineMode="MarkLines"       ;设置显示结点
res1@xyMarkerColor="black"            ;设置节点颜色
res1@xyMarker=3                       ;设置节点类型 默认为0
;res1@tmYLMode="Explicit"
;res1@tmYLValues=ispan(220, 255, 5)
;res1@tmYLLabels=res1@tmYLValues
res1@tmYLMode="Manual"
res1@tmYLTickStartF=220
res1@tmYLTickEndF=255
res1@tmYLTickSpacingF=5    ;这样有小刻度线（？
res1@trYMinF=220
res1@trYMaxF=255
res1@tiYAxisString="mintemp"
res1@tiYAxisFontColor="GreenYellow"

;-------------------------

res2=res
res2@gsnXYBarChart=True
res2@xyLineColors="pink"
res2@xyLineThicknesses=3
;res2@gsnXYBarChartColors="pink"          ;填充颜色
;res2@gsnXYBarChartFillOpacityF=0.3
res2@gsnXYBarChartBarWidth=1
;res2@tmYRMode="Explicit"
;res2@tmYRValues=ispan(0, 240, 40)
;res2@tmYRLabels=res2@tmYRValues
res2@tmYRMode="Manual"
res2@tmYRTickStartF=0
res2@tmYRTickEndF=240
res2@tmYRTickSpacingF=40
res2@trYMinF=0
res2@trYMaxF=240
res2@tiYAxisString="minarea"
res2@tiYAxisFontColor="pink"

plot=gsn_csm_xy2(wks, toint(hr), data1, data2, res1, res2)