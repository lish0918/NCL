delimiterSpc = " "
info     = asciiread("../DATA/ENSO_index-1960-2002winter.index", -1, "string")
;读取文本文件 
data      = tofloat(info)
year      = ispan(1960, 2002, 1)
data!0    = "year"
data&year = year

wks = gsn_open_wks("png", "homework-2")
drawNDCGrid(wks)  ;用于画网格线

res=True
res@gsnMaximize=True
res@gsnFrame=False

res@vpXF=0.1     
res@vpYF=0.73      
res@vpWidthF=0.95      
res@vpHeightF=0.5

res@tiXAxisString="year"
res@tiYAxisString="ENSO index"
res@tiXAxisFontHeightF = 0.025
res@tiYAxisFontHeightF = 0.025
 
res@trYMinF=-2.5     ;y轴最小坐标
res@trYMaxF=2.5    
res@trXMinF=1959
res@trXMaxF=2003

res@tmXTOn=False
res@tmXBOn=False  
res@tmYROn=False
res@tmYLMode="Explicit" ;array
res@tmYLValues=fspan(-2.5, 2.5, 11) ;total:11
res@tmYLLabels=res@tmYLValues
res@tmYLLabelFontHeightF=0.015

res@gsnXYBarChart=True    ;选择直方图
res@gsnXYBarChartBarWidth=0.4
res@gsnYRefLine=0     ;参考线位置
res@gsnYRefLineThicknessF=8.0   ;参考线宽度
res@gsnAboveYRefLineColor="red"    ;参考线上下颜色
res@gsnBelowYRefLineColor="blue"

res@tmYMajorGrid=True    ;y轴的主格网
res@tmYMajorGridLineColor="grey" 
res@tmYLMajorLengthF=0   ;y轴左侧主刻度的长度

plot=gsn_csm_xy(wks, year, data, res)
 
txres=True              ;加上横坐标年份字符
txres@txFontHeightF=0.012
txres@txAngleF=90
x=year
y=-0.5   ;控制位置
gsn_text(wks, plot, tostring(x), x, y, txres)
;gsn_text(wks, plot, text, x, y, res)

frame(wks)