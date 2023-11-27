;分别做两张图
da=asciiread("../DATA/HangZhou_temp_1993-2008-all.txt", -1, "string")
contents  = da(0)
str       = da(1:)
splitCont = str_split(contents, " ")  ; year, temp, clim_ave, temp_st

nrows = dimsizes(str) ;读取行数

nfields  = str_fields_count(str(0), " ") ;读取列数
;;print(nfields)  4cols
yrs      = str_get_field(str, 1, " ")    ;读取str第一列内容
data = new((/nrows,nfields-1/), "float",-999.9)
;      new(dimension_sizes, vartype, parameter)
do i=0,nfields-2
   data(:,i)  = tofloat(str_get_field(str, i+2, " ")) 
end do 

data!0="year"  ;二维
data!1="var"
data&year = yrs         ;coordinates
data&var  = splitCont(1:)
;print(data)

;------------------------------------------

wks     = gsn_open_wks("png", "homework-1-1") 

x=ispan(1, dimsizes(yrs), 1) ;=nrows
drawdata=data(:,0:1)

res=True
res@tiMainString  = "HangZhou_groundtemp_December"
res@tiXAxisString = drawdata!0  ;year
res@tiYAxisString = "temperature"+"("+"~S~o~N~C"+")" ;(℃)出错

res@tmXTOn       = False
res@tmYROn       = False
res@tmXBMode     = "Explicit"
res@tmXBValues   = x
res@tmXBLabels   = data&year 
res@tmXBLabelAngleF      = 300
res@tmXBLabelFontHeightF = 0.015
res@tmYLLabelFontHeightF = 0.015
res@trYMinF      = 0    
res@trYMaxF      = 9   

res@xyLineThicknessF = 4
res@xyLineColors     = (/"red","blue"/)  ;temp clim_ave

res@pmLegendDisplayMode    = "Always"      
res@xyExplicitLegendLabels = drawdata&var
res@lgPerimOn              = False            ; Turn off legend box 框
res@lgLabelFontHeightF     = 0.02
res@pmLegendWidthF         = 0.15             ; Resize legend width
res@pmLegendHeightF        = 0.08             ; and height
res@pmLegendOrthogonalPosF = -0.5             ; Move legend up
res@pmLegendParallelPosF   = 0.2             ; and to the right.

plot=gsn_csm_xy(wks, x, drawdata(var|:,year|:), res)
;drawdata(var|:,year|:) 横过来

;第二张图
drawdata2=data(:,2)

res2=True
res2@gsnFrame     = False

res2@tiMainString  = "HangZhou_groundtemp(standard)_December"
res2@tiXAxisString = drawdata!0
res2@tiYAxisString = "temperature-standard"+"("+"~S~o~N~C"+")"

res2@tmXTOn       = False
res2@tmYROn       = False
res2@tmXMajorGrid = True
res2@tmXMajorGridThicknessF       = 3.
res2@tmXMajorGridLineColor        = "grey"
res2@tmXMajorGridLineDashPattern  = 15    ;设置为虚线

res2@tmXBMode     = "Explicit"
res2@tmXBValues   = x
res2@tmXBLabels   = data&year 
res2@tmXBLabelAngleF      = 300
res2@tmXBLabelFontHeightF = 0.015
res2@tmYLLabelFontHeightF = 0.015

res2@trYMinF      = min(drawdata2)-1    
res2@trYMaxF      = max(drawdata2)+1   

res2@xyLineThicknessF = 4

plot2=gsn_csm_xy(wks, x, drawdata2, res2)

y       = drawdata2    ;显示点数据
y2      = y*0.
text    = sprintf("%5.2f", y)  ;格式化

txres=True
txres@gsFontColor   = "black"
txres@txFontHeightF = 0.015
gsn_text(wks, plot2, text, x+0.5, y+0.1, txres)
;gsn_text(wks, plot, text, x;位置, y, res)

lineres = True           ;添加一条线
lineres@gsLineThicknessF = 3
lineres@gsLineColor      = "red"
gsn_polyline(wks, plot2, x, y2, lineres)

frame(wks)
delete([/da,str,data/])