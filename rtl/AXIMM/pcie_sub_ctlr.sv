module pcie_sub_ctlr #(
   parameter  COUNTER_LEN = 6
   )(
   input                   clk       ,
   input                   rst_n     ,

   // Controller signals
   output logic            RdRqValid ,
   output logic  [63:0]    RdRqAddr  ,
   input         [127:0]   RdRqData  ,
   input                   RdRqReady ,
   input                   RdRqErr   ,

   // Controller signals
   output logic            WrRqValid ,
   output logic  [63:0]    WrRqAddr  ,
   output logic  [127:0]   WrRqData  ,
   input                   WrRqReady ,
   input                   WrRqErr   ,

   // Ib FIFO
   output        [127:0]   IbDataOut ,
   input         [31:0]    IbAddrOut ,
   input                   IbRdEn    ,

   output logic            IbDataValid,
   input                   IbRamValid,

   //Ob FIFO
   input                   ObWrEn,
   input         [31:0]    ObAddrIn,
   input         [127:0]   ObDataIn,

   input                   ObDataValid,
   output logic            ObRamValid

);


logic [31:0] IbPtrFn, IbPtrFn_Nxt ;
logic [31:0] IbPtrNxt, IbPtrNxt_Nxt ;

logic [31:0] ObPtrFn, ObPtrFn_Nxt ;
logic [31:0] ObPtrNxt, ObPtrNxt_Nxt ;



`define INIT_IB_REGION  64'h0_1000
`define NEXT_IB_REGION  64'h0
`define FINAL_IB_REGION 64'h10
`define MAX_IB          'h7

`define INIT_OB_REGION  64'h1_1000
`define NEXT_OB_REGION  64'h20
`define FINAL_OB_REGION 64'h30
`define MAX_OB          'h8

/*{COUNTER_LEN{1'b1}}*/
`define CNTR_MAX          'h20


typedef enum logic[10:0] {
   IDLE        = 'h000,
   LOAD_PTR    = 'h001,
   // WRT_PTR     = 'h002,
   WRT_FIFO    = 'h002,
   // RD_FIFO     = 'h008,
   WAIT_DONE   = 'h004,
   UPDATE_PTR  = 'h008,
   WRT_DATA    = 'h010,
   WRT_DTPTR   = 'h020,
   WAIT_WR_PTR = 'h040,
   CHK_PTR     = 'h080,
   INI_WR_DATA = 'h100
} CtlIbState ;


CtlIbState CtlIbSt, CtlIbSt_Nxt ;

logic             WrRqValid_Nxt ;
logic  [63:0]     WrRqAddr_Nxt ;
logic  [127:0]    WrRqData_Nxt ;

logic [127:0]     IbDataNxt;
logic [31:0]      IbAddrNxt;
logic             IbWrEnNxt;

logic [128-1:0]   IbData  ;
logic [31:0]      IbAddr  ;
logic             IbWrEn  ;

logic             ObRdEn, ObRdEn_Nxt;
logic [31:0]      ObAddrOut, ObAddrOut_Nxt;
wire [127:0]      ObDataOut;

logic             RdRqValid_Nxt;
logic [63:0]      RdRqAddr_Nxt;

logic             IbWrDone, ObRdDone;

logic [COUNTER_LEN-1:0] Cntr;


always_ff @(posedge clk or negedge rst_n) begin : proc_Cntr
   if(~rst_n) begin
      Cntr <= '0;
   end else begin
      if (Cntr == `CNTR_MAX) begin
         Cntr <= '0;
      end else begin
         Cntr <= Cntr + 1 ;
      end
   end
end


always_ff @(posedge clk) begin : proc_CtlIbSt
   if(~rst_n) begin
      CtlIbSt     <= IDLE;

      IbPtrFn     <= '0;
      IbPtrNxt    <= `INIT_IB_REGION;

      ObPtrFn     <= `INIT_OB_REGION;
      ObPtrNxt    <= '0;
      
      RdRqValid   <= '0 ;
      RdRqAddr    <= '0 ;

      WrRqValid   <= '0 ;
      WrRqAddr    <= '0 ;
      WrRqData    <= '0 ;

      IbData      <= '0 ;
      IbAddr      <= '0;
      IbWrEn      <= '0;

      ObRdEn      <= '0;
      ObAddrOut   <= '0;

   end else begin
      CtlIbSt     <= CtlIbSt_Nxt;
      
      IbPtrFn     <= IbPtrFn_Nxt  ;
      IbPtrNxt    <= IbPtrNxt_Nxt ;

      ObPtrFn     <= ObPtrFn_Nxt  ;
      ObPtrNxt    <= ObPtrNxt_Nxt ;

      RdRqValid   <= RdRqValid_Nxt ;
      RdRqAddr    <= RdRqAddr_Nxt ;

      WrRqValid   <= WrRqValid_Nxt ;
      WrRqAddr    <= WrRqAddr_Nxt ;
      WrRqData    <= WrRqData_Nxt ;

      IbData      <= IbDataNxt ;
      IbAddr      <= IbAddrNxt;
      IbWrEn      <= IbWrEnNxt ;

      ObRdEn      <= ObRdEn_Nxt;
      ObAddrOut   <= ObAddrOut_Nxt;

   end
end

always_comb begin : proc_IB_Ptr
   RdRqValid_Nxt  = 1'h0;
   IbPtrFn_Nxt    = IbPtrFn ;
   IbPtrNxt_Nxt   = IbPtrNxt ;

   ObPtrFn_Nxt    = ObPtrFn;
   ObPtrNxt_Nxt   = ObPtrNxt;

   CtlIbSt_Nxt    = CtlIbSt ;

   ObRdEn_Nxt     = ObRdEn;
   ObAddrOut_Nxt  = ObAddrOut;



   WrRqData_Nxt   = WrRqData ;
   WrRqValid_Nxt  = 1'h0;
   WrRqAddr_Nxt   = WrRqAddr ;

   RdRqAddr_Nxt   = RdRqAddr ;

   IbWrEnNxt      = 0;
   IbAddrNxt      = IbAddr;
   IbDataNxt      = IbData;

   IbWrDone = 0;
   ObRdDone = 0;

   case (CtlIbSt)
      IDLE: begin
         if (Cntr == `CNTR_MAX ) begin
            CtlIbSt_Nxt = LOAD_PTR;

            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = `FINAL_IB_REGION;
         end
      end
      LOAD_PTR: begin
         if (RdRqReady & ~RdRqErr) begin
            IbPtrFn_Nxt = RdRqData[31:0] ;

            if (IbPtrFn_Nxt[15:12] != IbPtrNxt[15:12]) begin
               CtlIbSt_Nxt = WRT_FIFO;

               //
               RdRqValid_Nxt = 1;
               RdRqAddr_Nxt  = IbPtrNxt;

               // FIFO interface
               IbAddrNxt = '1;
            end else begin
               CtlIbSt_Nxt = IDLE;

               //
               RdRqValid_Nxt = 0;
            end
         end
         else /*if (RdRqReady & RdRqErr)*/ begin
            CtlIbSt_Nxt = LOAD_PTR;

            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = `FINAL_IB_REGION;
         end /*else begin
            CtlIbSt_Nxt = CtlIbSt ;
         end*/
      end
      WRT_FIFO :begin
         if (RdRqReady & ~RdRqErr) begin
            IbDataNxt = RdRqData[127:0] ;
            IbAddrNxt = IbAddr + 1;
            IbWrEnNxt   = 1;

            if (IbAddrNxt == 32'h64) begin // 100
               CtlIbSt_Nxt = UPDATE_PTR;
               IbWrDone    = 1;

               //
               WrRqValid_Nxt = 1;
               WrRqAddr_Nxt  = `NEXT_IB_REGION;

               if (IbPtrNxt[15:12] == 4'h7) begin
                  WrRqData_Nxt[15:12] = 4'h0;
               end else begin
                  WrRqData_Nxt[15:12] = IbPtrNxt[15:12] + 4'h1;
               end

               RdRqValid_Nxt = 0;

            end else begin
               CtlIbSt_Nxt = WRT_FIFO;
               IbWrDone    = 0;

               RdRqValid_Nxt = 1;
               RdRqAddr_Nxt  = IbPtrNxt + 64'h10;
            end
         end else begin
            CtlIbSt_Nxt = WRT_FIFO;

            IbDataNxt = IbData;
            IbAddrNxt = IbAddr;
            IbWrEnNxt = 0;

            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = IbPtrNxt ;
         end
      end
      UPDATE_PTR : begin
         if (WrRqReady  & ~WrRqErr) begin
            CtlIbSt_Nxt = WAIT_DONE;
            WrRqValid_Nxt = 0;

            if (IbPtrNxt[15:12] == 4'h7) begin
               IbPtrNxt_Nxt = `INIT_IB_REGION;
            end else begin
               IbPtrNxt_Nxt[15:12] = IbPtrNxt[15:12] + 4'h1;
               IbPtrNxt_Nxt[11:0]  = '0;
            end
         end else begin
            CtlIbSt_Nxt = UPDATE_PTR;

            WrRqValid_Nxt = 1;
            WrRqAddr_Nxt  = `NEXT_IB_REGION;

            IbPtrNxt_Nxt = IbPtrNxt ;
            if (IbPtrNxt[15:12] == 4'h7) begin
               WrRqData_Nxt[15:12] = 4'h0;
            end else begin
               WrRqData_Nxt[15:12] = IbPtrNxt[15:12] + 4'h1;
            end
         end
      end
      WAIT_DONE: begin
         if (ObDataValid) begin
            CtlIbSt_Nxt = CHK_PTR;

            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = `NEXT_OB_REGION;

         end else begin
            RdRqValid_Nxt  = 0;

         end
      end
      WAIT_WR_PTR: begin

         if (Cntr == `CNTR_MAX  ) begin
            CtlIbSt_Nxt = CHK_PTR;

            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = `NEXT_OB_REGION;

            ObRdEn_Nxt = 1;
            ObAddrOut_Nxt = 0;
         end else begin
            RdRqValid_Nxt = 0;
            RdRqAddr_Nxt  = RdRqAddr ;

            ObRdEn_Nxt = 0;
            ObAddrOut_Nxt = 0;
         end
      end
      CHK_PTR: begin

         if (RdRqReady & ~RdRqErr) begin
            RdRqValid_Nxt = 0;
            RdRqAddr_Nxt  = '0;

            if (RdRqData[15:12] == 4'h0 && ObPtrFn[15:12] == `MAX_OB || 
                  ObPtrFn[15:12] + 4'h1 == RdRqData[15:12]
               ) begin // wait for writing
               CtlIbSt_Nxt = WAIT_WR_PTR ;

               ObRdEn_Nxt = 1;
               ObAddrOut_Nxt = 0;
            end else begin
               CtlIbSt_Nxt = INI_WR_DATA;

               ObRdEn_Nxt = 1;
               ObAddrOut_Nxt = 32'h0;
            end

         end else begin
            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = `NEXT_OB_REGION;

            ObRdEn_Nxt = 0;
            ObAddrOut_Nxt = 0;
         end
      end
      INI_WR_DATA: begin

         WrRqValid_Nxt  = 0;
         WrRqData_Nxt   = ObDataOut;

         WrRqAddr_Nxt[63:0] = {32'h0, ObPtrFn[31:0]};

         CtlIbSt_Nxt    = WRT_DATA;

         ObRdEn_Nxt     = 1;
         ObAddrOut_Nxt  = ObAddrOut + 32'h1;
      end
      WRT_DATA: begin

         if (WrRqReady & ~WrRqErr) begin
            if (ObAddrOut == 'h64) begin // 100
               CtlIbSt_Nxt   = WRT_DTPTR;

               ObRdEn_Nxt    = 0;
               ObAddrOut_Nxt = 0;

               WrRqValid_Nxt = 1;
               WrRqAddr_Nxt  = `FINAL_OB_REGION;
               if (ObPtrFn[15:12] == `MAX_OB) begin
                  WrRqData_Nxt = '0;
               end else begin
                  WrRqData_Nxt[15:12] = ObPtrFn[15:12] + 4'h1;
               end
            end else begin
               ObRdEn_Nxt    = 1;
               ObAddrOut_Nxt = ObAddrOut + 32'h1;
               WrRqValid_Nxt = 1;
               WrRqAddr_Nxt  = WrRqAddr + 64'h10;
               WrRqData_Nxt  = ObDataOut;
            end
         end else begin
            ObRdEn_Nxt    = 0;
            ObAddrOut_Nxt = ObAddrOut;
            WrRqValid_Nxt = 1;
            WrRqAddr_Nxt  = WrRqAddr;
            WrRqData_Nxt  = WrRqData;
         end
      end
      WRT_DTPTR: begin

         if (WrRqReady & ~WrRqErr) begin
            WrRqValid_Nxt =  0;
            WrRqAddr_Nxt  = '0;
            WrRqData_Nxt  = '0;

            CtlIbSt_Nxt   = IDLE;
            ObRdDone      = 1;

            if (ObPtrFn[15:12] == `MAX_OB) begin
               ObPtrFn_Nxt = `INIT_OB_REGION;
            end else begin
               ObPtrFn_Nxt[15:12] = ObPtrFn[15:12] + 4'h1;
               ObPtrFn_Nxt[11:0]  = '0;
            end
         end else begin
            CtlIbSt_Nxt = CtlIbSt;
            ObRdDone    = 0;

            WrRqValid_Nxt = 1;
            WrRqAddr_Nxt  = `FINAL_OB_REGION;
            if (ObPtrFn[15:12] == `MAX_OB) begin
               WrRqData_Nxt = '0;
            end else begin
               WrRqData_Nxt[15:12] = ObPtrFn[15:12] + 'h1;
            end
         end
      end
      default : CtlIbSt_Nxt = CtlIbSt;
   endcase
end



////////////////////
// RAM

ram m_ram_Ib_0 (
   .WrEn   ( IbWrEn    ) ,
   .WrAddr ( IbAddr    ) ,
   .WrData ( IbData    ) ,

   .RdEn   ( IbRdEn    ) ,
   .RdAddr ( IbAddrOut ) ,
   .RdData ( IbDataOut ) ,

   .clk    ( clk       )  
) ;


ram m_ram_Ob_0 (
   .clk    ( clk       ) ,

   .WrEn   ( ObWrEn    ) ,
   .WrAddr ( ObAddrIn  ) ,
   .WrData ( ObDataIn  ) ,

   .RdEn   ( ObRdEn    ) ,
   .RdAddr ( ObAddrOut ) ,
   .RdData ( ObDataOut )
);


IbObRamCtlr m_IbObRamCtlr(
   .clk         ( clk         ) ,
   .rst_n       ( rst_n       ) ,

   .IbWrDone    ( IbWrDone    ) ,
   .IbDataValid ( IbDataValid ) ,
   .IbRamValid  ( IbRamValid  ) ,

   .ObRdDone    ( ObRdDone    ) ,
   .ObDataValid ( ObDataValid ) ,
   .ObRamValid  ( ObRamValid  ) 
) ;

endmodule : pcie_sub_ctlr


