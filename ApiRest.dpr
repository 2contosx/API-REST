program ApiRest;

{$APPTYPE CONSOLE}

{$R *.res}

uses Horse,
JOSE.Core.JWT,
JOSE.Core.Builder,
System.SysUtils;

begin
  WriteLn( 'On-line e servindo !' );
  THorse.Get('/login',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
var
  LToken: TJWT;
  LCompactToken: string;
begin

  LToken := TJWT.Create;
  try

    // Token claims
    LToken.Claims.Issuer := 'Fernandes.Yan soft';
    LToken.Claims.Subject := 'Teste Api 1.0';
    LToken.Claims.Expiration := Now + 1;
    // criando claims

    LToken.Claims.SetClaimOfType<string>('nome', 'Yan Pablo');
    LToken.Claims.SetClaimOfType<Boolean>('Programador Delphi', True);
    Res.Send(lcompactToken);
       // Criação de assinatura e formato compactado
    LCompactToken := TJOSE.SHA256CompactToken('key', LToken);
    Res.Send(LCompactToken);
    finally
    LToken.Free;
  end;
 end);


  THorse.Listen(9000);
end.
