pragma solidity ^0.7.5;


contract Premios {
    
    enum EstadoPremio {CREADO, ACEPTADO, CANCELADO}  
    
    // estrucura nueva define Premio.
    struct Premio { 
        address persona ;
        uint deadline;
        string data ;
        EstadoPremio estado ;
        uint monto;
    }
 
   // arreglos para guarsar los premios y contatos 
   Premio[]  public premios;
 
    constructor() public {}  //constructor de la clase
    
 
  
 
 function  publicarPremio(string memory _data, uint64 _deadline)  public  payable  
 tieneValor()   
 validarDeadline(_deadline)
 returns  (uint)  { 

     /** Se agrega en el arreglo de peemios un nuevo premio con estado inicial CREADO
      * en el cual se validara el deadline y valor con las
      * fucniones  tieneValor y  validarDeadline
      * 
      * Los siguientes parametros se usan cuando se despliega.
      * msg.sender indicara quien esta creando el permio/contrato
      * msg.value  cual es el valor del premio que se asignara
      * 
      */
     premios.push(Premio(msg.sender,    // dirección de la persona que crea el premio.
     _deadline,                         // fecha de deadline
     _data,                             //
     EstadoPremio.CREADO,               // estado inicial del premio en CREADO
     msg.value));                       // monto del premio, parametro 
     
     // se genera evento de notificación que se agrego un nuevo premio 
     emit PremioAgregado(premios.length -1, msg.sender, msg.value, _data);  
     return (premios.length - 1 );  
 }
 
  /**
   *  validarDeadline, valida que la fecha de deadline es mayor que la fecha de hoy (now)
   *  block.timestamp es la fecha de hoy
   */
  
  modifier validarDeadline(uint _nuevoDeadline) {  
     // require ( _nuevoDeadline > now ); 
      require ( _nuevoDeadline > block.timestamp ); 
      _; 
  }
 
  /**
   * tieneValor, valida que el valor recivido sea mayor que 0.
   */
  modifier tieneValor() {
      require (msg.value > 0 );
      _; 
  }
  
  // Agregando eventos
  event PremioAgregado(uint id_premio, address persona, uint monto, string data);
  
 }
