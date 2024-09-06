module Sign_bit(SignA, SignB, Sign);
input SignA, SignB ;
output Sign;
assign Sign = (SignA ^ SignB);

endmodule