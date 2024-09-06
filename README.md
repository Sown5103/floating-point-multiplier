# floating-point-multiplier
perform 32-bit floating point multiplier, can handle special case
![image](https://github.com/user-attachments/assets/6de07372-805c-4f66-9f33-1f48d28cdfae)
![image](https://github.com/user-attachments/assets/d25e539f-c37d-40b2-9da9-312a6d54220f)
− Datapath bao gồm những khối sau: Comparator, EnableRegMul, Mux4to1_32bit, Sign_Extend, Multi, Rounding, Concatenation, ALU.
2.1. Khối Comparator.
− Khối Comparator 31 bit thực hiện chức năng so sánh cả hai input In1, In2 với 0.
− Nếu một trong hai input hoặc cả hai input đều bằng 0 thì xuất tín hiệu output Equal = 1, ngược lại Equal = 0.
2.2. Khối ALU.
− Khối ALU 8 bit thực hiện chức năng cộng 2 số mũ In1, In2 từ bit thứ 30 đến bit thứ 23. Sau đó trừ 127 để tính ra số mũ mới cho kết quả.
− Output Out được nối tới Register 8 bit.
− Nếu phép cộng bị tràn thì Over1 = 1, ngược lại Over1 = 0.
2.3. Khối Register8bit.
− Khối Register8bit thực hiện chức năng ghi, đọc, lưu trữ dữ liệu từ ALU.
− Input In của Register8bit được nối từ ouput Out của ALU. Kết quả sau khi tính toán của ALU sẽ được đưa vào trong Register8bit để lưu trữ.
− WE (Write Enable) là input có chức năng cho phép ghi dữ liệu vào thanh ghi khi WE = 1. Được nối từ output WE của khối EnableRegMul.
− RE (Read Enable) là input có chức năng cho phép đọc dữ liệu ra thanh ghi khi RE = 1. Được nối từ output RE của khối EnableRegMul.
− Reset là input có chức năng đưa thanh ghi về trạng thái ban đầu để tránh dữ liệu rác.
− Dựa vào các input mà output Out sẽ xuất ra các dữ liệu tương ứng. Output Out của Register8bit được nối tới input Ex của khối Rounding.
2.4. Khối Sign_Extend.
− Khối Sign_Extend thực hiện chức năng mở rộng bit từ 23 bit thành 24 bit.
− Input In của khối (1) và (2) được lấy từ phần Mantissa[22:0] của In1 và In2 tương ứng.
− Tín hiệu input St_SE từ output Equal của khối Comparator cho phép khối này mở rộng bit.
− Output Out của khối (1) được nối tới Multiplier và ouput Out của khối (2) được nối tới Multiplicand của khối Multi.
− Kết quả sau khi mở rộng bit: 1xxxxxxxxxxxxxxxxxxxxxxx
2.5. Khối Multi.
2.5.1. Giải thuật và kiến trúc chung.
− Giải thuật: 
 
Hình 3: Giải thuật cho khối Multi.
− Kiến trúc chung:
 
Hình 4: Kiến trúc chung của khối Multi.
2.5.2. Datapath.
 
Hình 5: Datapath của khối Multi.
− Khối Sign_extendM
+ Khối Sign_extendM thực hiện chức năng mở rộng bit từ 24 bit thành 48 bit.
+ Input In được lấy từ input Multiplier, ouput Out được nối với In1 của Mux2to1_48b.
− Khối Mux2to1_48bit:
+ Khối Mux2to1_48bit thực hiện chức năng chọn một trong hai input In1, In0 dựa vào tín hiệu điều khiển S.
+ Input In1 được nối với Out của khối Sign_ExtendM, input In0 được nối với Out của Khối Shift_right, tín hiệu điều khiển S được lấy từ tín hiệu Init_En của khối Controller.
+ Output Out được nối tới input In của Register48bit.
− Khối Add_24bit:
+ Khối Add_24bit thực hiện chức năng cộng 2 input 24bit In1, In2. Với kết quả được xuất ra output Out và được nối với In2 của khối Concatenation1.
+ Output Over là bit tràn, được nối với input InOv của khối Concatenation1.
− Khối Concatenation:
+ Gộp hai input 24 bit và một input 1 bit thành một output có 49 bit được nối với input In1 của khối Mux2to1_48bit, theo thứ tự bit InOv_In2_In1.
− Khối UpCounter:
+ Thực hiện chức năng đếm lên (từ 0 đến 23) theo tín hiệu nghịch đảo của Init_En sau mỗi chu kỳ xung clock.
+ Khi đếm tới 23, ouput gửi tín hiệu DoneC = 1 tới Controller.
− Khối Shift_right1b:
+ Thực hiện chức năng dịch phải 1 bit input In 49 bit, kết quả được xuất ra output Out, tuy nhiên chỉ lấy bit [47:0] của Out.
− Khối Register48bit đã được trình bày ở mục 2.3
2.5.3. Controller.
− Sơ đồ chuyển trạng thái:
 
Hình 6: Sơ đồ chuyển trạng thái của khối Multi.
− Trước khi bắt đầu thì Start = 0, tất cả trạng thái đều được reset về 0 để tránh dữ liệu rác.
+ Khi Start = 1, S0 -> S1:
•	Init_En = 1 cho phép Mux2to1_48b chọn input là Multiplier (đã được mở rộng bit), đồng thời chưa cho phép khối UpCounter thực hiện việc đếm.
•	WE = 1 cho phép Register48bit ghi dữ liệu từ Mux2to1_48b vào thanh ghi, RE = 1 cho phép Register48bit đọc dữ liệu ra để thực hiện các tác vụ bên Datapath.
•	DoneO = 0 để Tristate không cho dữ liệu đi ra Output
+ Khi Start = 0, S1 -> S2:
•	Init_En = 0 => EnC = 1: Cho phép khối UpCounter thực hiện việc đếm lên.
•	WE = 1 cho phép Register48bit ghi dữ liệu từ Mux2to1_48b vào thanh ghi, RE = 1 cho phép Register48bit đọc dữ liệu ra để thực hiện các tác vụ bên Datapath.
•	DoneO = 0 để Tristate không cho dữ liệu đi ra Output
•	Nếu Start = 1 thì quay về trạng thái S1.
+ Khi DoneC = 1:
•	RE = 1, DoneO = 1 cho phép xuất ra kết quả Output.
2.6. Khối Enable_Reg_Mul.
−  Thực hiện chức năng đếm số chu kỳ, cho phép Register48bit và Multi thực thi.
− Input St_Count = 1 cho phép khối này bắt đầu đếm chu kỳ, tín hiệu được lấy từ tín hiệu Start của Controller.
− Output WE được nối với input WE của Register8bit, thực hiện chức năng cho phép ghi dữ liệu vào thanh ghi khi WE = 1 tại chu kỳ đếm đầu tiên của khối.
− Output RE được nối với input RE của Register8bit, thực hiện chức năng cho phép đọc dữ liệu từ thanh ghi khi RE = 1 tại chu kỳ đếm thứ 25 của khối.
− Output Start_Multi được nối với input Start_Multi của khối Multi, thực hiện chức năng cho phép khối Multi thực hiện phép nhân khi Start_Multi = 1 tại chu kỳ đếm đầu tiên của khối.
2.7. Khối Rounding.
− Thực hiện chức năng đưa về dạng chuẩn và làm tròn để phần thập phân chỉ có 23 bit.
− Có các tín hiệu đi vào khối Rounding bao gồm: Start, Ex, M lần lượt là tín hiệu bắt đầu Rounding, phần mũ và phần thập phân.
− Khối Rounding thực hiện kiểm tra xem đúng dạng chuẩn (dạng chuẩn tức kết quả có 2 bit 01 là bit thứ 47 và 46, vì kết quả được lấy từ bit thứ 45 đến 23, tức là phần sau dấu chấm) hay chưa. Nếu chưa thì cần đưa về dạng chuẩn đồng thời tăng phần mũ 1 đơn vị. Nhưng nếu phần mũ có giá trị hiện tại là 254 thì không thể cộng được nữa nên trường hợp đó sẽ gây ra tràn. Ngược lại dịch phải phần thập phân 1 bit và cộng phần mũ 1 đơn vị. Còn nếu đã là dạng chuẩn thì không có gì thay đổi.
− Vì chỉ lấy đúng 23 bit phần thập phân( từ bit 23 đến bit 45) nên nếu bit 22 bằng 1 thì 23 bit đó sẽ cộng thêm 1( nếu có tràn thì cũng làm tương tự như trên, tiếp tục dịch phải phần thập phân và cộng số mũ lên 1). Ngược lại sẽ giữ nguyên 23 bit.
− Output nhận được chính là phần thập phân và phần mũ đã được làm tròn.
2.8. Khối Mux_4_1_32 bit.
− Thực hiện chức năng chọn một trong bốn tín hiệu đầu vào dựa trên tín hiệu điều khiển S.
− Input 00 được nối từ output Out của khối Concatenation, input 01 được gán trạng thái Hi-Z, input 10 và 11 được gán giá trị 0.
− Output Out được nối với input In của khối Tristate.
2.9. Khối Tristate.
− Input In được nối với ouput Out của khối Mux4to1_32bit.
− Input En được nối với tín hiệu DoneO từ Controller, cho phép dữ liệu đi qua khi DoneO = 1.
− Output Out được nối ra Output để hiển thị kết quả cuối cùng.

![image](https://github.com/user-attachments/assets/d2de6774-d695-47d6-be0f-de116a4c737b)
o	Trước khi bắt đầu (Start = 0), tất cả trạng thái đều được reset về 0 để tránh dữ liệu rác.
o	Khi Start = 1: Trạng thái S0 chuyển sang S1.
•	Tại S1: Nếu Equal = 1, S = 10 và DONE = 1 để xuất giá trị 0 tại Output. Nếu Over1 = 1, S = 01 và DONE = 1 để xuất giá trị HiZ tại Output.
o	Khi Equal = 0 và Over1 = 0: Trạng thái S1 chuyển sang S2.
o	Khi DoneM = 1, Trạng thái S2 chuyển sang S3.
•	Tại S3: Nếu Over2 = 1 và DoneR = 0 => S = 01, DONE = 1 để xuất tín hiệu HiZ. Nếu Over2 = 0 và DoneR = 1 => StartR = 1 để cho phép khối Rounding thực hiện.
o	Over2 = 0, DoneR = 1 => Trạng thái S3 chuyển sang S4.
•	Tại S4: Nếu DoneR = 0 => S = 01, DONE = 1 để xuất tín hiện HiZ. Nếu DoneR = 1 => S = 00, DONE = 1 để xuất ra kết quả tính được.

![image](https://github.com/user-attachments/assets/b260558d-2542-4baf-8ab4-eb5ed0d31739)
