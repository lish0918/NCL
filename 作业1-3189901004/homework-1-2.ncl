;呈现在一张图上
da=asciiread("../DATA/HangZhou_temp_1993-2008-all.txt", -1, "string")
contents  = da(0)
str       = da(1:)
splitCont = str_split(contents, " ")  
 
nrows = dimsizes(str) ;读取行数

nfields  = str_fields_count(str(0), " ")
yrs      = str_get_field(str, 1, " ")
data = new((/nrows,nfields-1/), "float",-999.9)

do i=0,nfields-2
   data(:,i)  = tofloat(str_get_field(str, i+2, " ")) 
end do 

data!0="year"
data!1="var"
data&year = yrs
data&var  = splitCont(1:)

;--------------------------------------

wks     = gsn_open_wks("png", "homework-1-2")

;;prepare and draw first plot 

x=ispan(1, dimsizes(yrs), 1)
drawdata=data(:,0:1)

res=True
res@gsnDraw      =  False
res@gsnFrame     =  False    ;default:True  false:不翻页
 
res@vpXF        = 0.2      
res@vpYF        = 0.9    
res@vpWidthF  = 0.7        
res@vpHeightF = 0.3

res@tiMainString  = "HangZhou_groundtemp_December"
res@tiXAxisString = drawdata!0
res@tiYAxisString = "temperature"+"("+"~S~o~N~C"+")"

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
res@xyLineColors     = (/"red","blue"/)

res@pmLegendDisplayMode    = "Always"
res@xyExplicitLegendLabels = drawdata&var
res@lgPerimOn              = False            ; Turn off legend box
res@lgLabelFontHeightF     = 0.02
res@pmLegendWidthF         = 0.15             ; Resize legend width
res@pmLegendHeightF        = 0.08             ; and height
res@pmLegendOrthogonalPosF = -0.7             ; Move legend up
res@pmLegendParallelPosF   = 0.2             ; and to the right.

plot=gsn_csm_xy(wks, x, drawdata(var|:,year|:), res)
draw(plot)

;图2 
drawdata2=data(:,2)
printVarSummary(drawdata2)
res2=True
res2@gsnFrame     = False
res2@gsnDraw      = False

res2@vpXF        = 0.2  
res2@vpYF        = 0.4      
res2@vpWidthF    = 0.7     
res2@vpHeightF   = 0.3

res2@tiMainString  = "HangZhou_groundtemp(standard)_December"
res2@tiXAxisString = drawdata!0
res2@tiYAxisString = "temperature-standard"+"("+"~S~o~N~C"+")"

res2@tmXTOn       = False
res2@tmYROn       = False
res2@tmXMajorGrid = True
res2@tmXMajorGridThicknessF       = 3.
res2@tmXMajorGridLineColor        = "grey"
res2@tmXMajorGridLineDashPattern  = 15

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
draw(plot2)

y       = drawdata2
y2      = y*0.
text    = sprintf("%5.2f", y)  

txres=True
txres@gsFontColor   = "black"
txres@txFontHeightF = 0.015
gsn_text(wks, plot2, text, x+0.5, y+0.1, txres)

lineres = True
lineres@gsLineThicknessF = 3
lineres@gsLineColor      = "red"
gsn_polyline(wks, plot2, x, y2, lineres)

frame(wks)
delete([/da,str,data/])