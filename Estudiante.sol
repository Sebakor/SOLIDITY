pragma solidity ^0.8.10;

contract TPSolidity {

    string private _apellido;
    string private _nombre;
    address private _docente;
    string private _curso;
    mapping (string => uint) private notas_materia;
    string[] private NombresMaterias;

    constructor(string memory nombre_, string memory apellido_, string memory curso_) {
        _docente = msg.sender;
        _nombre = nombre_;
        _curso = curso_;
        _apellido = apellido_;
        
    }
    function apellido() public view returns (string memory) {
        return _apellido;
    }
    function nombre_completo() public view returns (string memory) {
        return string(abi.encodePacked(_nombre," ",_apellido));
    } 
    function curso() public view returns (string memory) {
        return _curso;
    }
    function set_nota_materia(uint _nota, string memory _materia) public {
        require(_docente == msg.sender, "Solo los docentes pueden cambiar la nota");
        require(_nota <= 100 && _nota >= 1, "No es una nota valida");
        NombresMaterias.push(_materia);
        notas_materia[_materia] = _nota;
    }
    function nota_materia(string memory _materia) public view returns (uint) {
        uint _nota = notas_materia[_materia];   
        return _nota;
    }
    function aprobo(string memory _materia) public view returns (bool) {
        if (notas_materia[_materia] >= 60){
            return true;
        } 
        else 
        {
            return false;
        } 
    }
    function promedio() public view returns (uint) {
        uint notabruto;
        uint notaneto;
        for (uint i = 0; i < NombresMaterias.length; i++){
            notabruto += notas_materia[NombresMaterias[i]];
        }
        
        notaneto = notabruto / NombresMaterias.length;
        return notaneto;
    }
}