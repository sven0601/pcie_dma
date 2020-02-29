// O     [31:0]   m_axi_araddr  
// O     [1:0]    m_axi_arburst 
// O     [0:0]    m_axi_arid    
// O     [7:0]    m_axi_arlen   
// I              m_axi_arready 
// O     [2:0]    m_axi_arsize  
// O              m_axi_arvalid 
         
// O     [31:0]   m_axi_awaddr  
// O     [1:0]    m_axi_awburst 
// O     [0:0]    m_axi_awid    
// O     [7:0]    m_axi_awlen   
// I              m_axi_awready 
// O     [2:0]    m_axi_awsize  
// O              m_axi_awvalid 
         
// I     [0:0]    m_axi_bid     
// O              m_axi_bready  
// I     [1:0]    m_axi_bresp   
// I              m_axi_bvalid  
// O              m_axi_wlast   
// I              m_axi_wready  
// O     [7:0]    m_axi_wstrb   
// O              m_axi_wvalid  
// O     [63:0]   m_axi_wdata   
         
// I     [63:0]   m_axi_rdata   
// I     [0:0]    m_axi_rid     
// I              m_axi_rlast   
// O              m_axi_rready  
// I     [1:0]    m_axi_rresp   
// I              m_axi_rvalid  


enum logic[3:0] {
   GETADDR = 4'h1 ,
   GETDATA = 4'h2 ,
   FAULT   = 4'h4
} JtagAxiSt ;



logic ArReady ;
logic lg_EnRamJtag ;

assign   m_axi_arready = ArReady ;
assign   EnRamJtag     = lg_EnRamJtag ;

/**
 * 
 */


always_ff @(posedge aclk or negedge aresetn) begin : proc_GetData
   if (~aresetn) begin
      ArReady        <= 1 ;
      lg_EnRamJtag   <= 0 ;
      JtagAxiSt      <= GETADDR ;
   end else begin
      case (JtagAxiSt)
         GETADDR   : begin
            if (m_axi_arvalid) begin
               if (m_axi_arburst != 1
                     || m_axi_arlen != 0 
                     || m_axi_arsize != 4) begin
                  JtagAxiSt   <= FAULT ;
               end else begin
                  JtagAxiSt   <= GETDATA ;
                  if (m_axi_araddr[19] == 1'h1) begin
                     lg_EnRamJtag   <= 1 ;
                  end else begin
                     lg_EnRamJtag   <= 0 ;
                  end
               end
               ArReady              <= 0 ;
            end
         end
         GETDATA: begin

         end
         FAULT: begin

         end
      endcase
   end
end



