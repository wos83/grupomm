unit uUser;

interface

uses
  Pkg.Json.DTO,
  System.Generics.Collections,
  REST.Json,
  REST.Json.Types;

{$M+}

type
  TToken = class
  private
    FCredential: string;
    FEmission: string;
    FLifetime: Integer;
    FType: string;
  published
    property Credential: string read FCredential write FCredential;
    property Emission: string read FEmission write FEmission;
    property Lifetime: Integer read FLifetime write FLifetime;
    property &Type: string read FType write FType;
  end;

  TEntity = class
  private
    FBlocked: Boolean;
    FContractor: Boolean;
    FContractorId: Integer;
    FCooperative: Boolean;
    FCustomer: Boolean;
    FEntitytypeId: Integer;
    FEntitytypename: string;
    FId: Integer;
    FJuridicalperson: Boolean;
    FName: string;
    FSeller: Boolean;
    FServiceprovider: Boolean;
    FSupplier: Boolean;
  published
    property Blocked: Boolean read FBlocked write FBlocked;
    property Contractor: Boolean read FContractor write FContractor;
    property ContractorId: Integer read FContractorId write FContractorId;
    property Cooperative: Boolean read FCooperative write FCooperative;
    property Customer: Boolean read FCustomer write FCustomer;
    property EntitytypeId: Integer read FEntitytypeId write FEntitytypeId;
    property Entitytypename: string read FEntitytypename write FEntitytypename;
    property Id: Integer read FId write FId;
    property Juridicalperson: Boolean read FJuridicalperson write FJuridicalperson;
    property Name: string read FName write FName;
    property Seller: Boolean read FSeller write FSeller;
    property Serviceprovider: Boolean read FServiceprovider write FServiceprovider;
    property Supplier: Boolean read FSupplier write FSupplier;
  end;

  TUser = class(TJsonDTO)
  private
    FCreatedat: string;
    FDetail: string;
    FEmail: string;
    FEntity: TEntity;
    FExpires: Boolean;
    FForcenewpassword: Boolean;
    FGroupId: Integer;
    FGroupname: string;
    FId: Integer;
    FInstance: string;
    FLastlogin: string;
    FName: string;
    FPhonenumber: string;
    FRole: string;
    FStatus: Integer;
    FTitle: string;
    FToken: TToken;
    FUpdatedat: string;
    FUsername: string;
  published
    property Createdat: string read FCreatedat write FCreatedat;
    property Detail: string read FDetail write FDetail;
    property Email: string read FEmail write FEmail;
    property Entity: TEntity read FEntity;
    property Expires: Boolean read FExpires write FExpires;
    property Forcenewpassword: Boolean read FForcenewpassword write FForcenewpassword;
    property GroupId: Integer read FGroupId write FGroupId;
    property Groupname: string read FGroupname write FGroupname;
    property Id: Integer read FId write FId;
    property Instance: string read FInstance write FInstance;
    property Lastlogin: string read FLastlogin write FLastlogin;
    property Name: string read FName write FName;
    property Phonenumber: string read FPhonenumber write FPhonenumber;
    property Role: string read FRole write FRole;
    property Status: Integer read FStatus write FStatus;
    property Title: string read FTitle write FTitle;
    property Token: TToken read FToken;
    property Updatedat: string read FUpdatedat write FUpdatedat;
    property Username: string read FUsername write FUsername;
  public
    constructor Create; override;
    destructor Destroy; override;

    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TUser;
  end;

var
  FUser: TUser;

implementation

{ TUser }

constructor TUser.Create;
begin
  inherited;
  FEntity := TEntity.Create;
  FToken := TToken.Create;
end;

destructor TUser.Destroy;
begin
  FEntity.Free;
  FToken.Free;
  inherited;
end;

function TUser.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

class function TUser.FromJsonString(AJsonString: string): TUser;
begin
  Result := TJson.JsonToObject<TUser>(AJsonString);
end;

end.
