//
//  Created by Federico Giuntoli on 29/08/20.
//

import Foundation

// MARK: - Entità in comune

public struct Indirizzo: Codable {
    public var indirizzo: String
    public var numeroCivico: String?
    public var cap: Int
    public var comune: String
    public var provincia: String?
    public var nazione: String
    
    public init(indirizzo: String, numeroCivico: String?, cap: Int, comune: String, provincia: String?, nazione: String) {
        self.indirizzo = indirizzo
        self.numeroCivico = numeroCivico
        self.cap = cap
        self.comune = comune
        self.provincia = provincia
        self.nazione = nazione
    }

    enum CodingKeys: String, CodingKey{
        case indirizzo = "indirizzo"
        case numeroCivico =  "numerocivico"
        case cap = "cap"
        case comune = "comune"
        case provincia = "provincia"
        case nazione = "nazione"
    }

    enum EncodableKeys: String, CodingKey {
        case indirizzo = "Indirizzo"
        case numeroCivico =  "NumeroCivico"
        case cap = "CAP"
        case comune = "Comune"
        case provincia = "Provincia"
        case nazione = "Nazione"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.indirizzo, forKey: .indirizzo)
        try container.encode(self.numeroCivico, forKey: .numeroCivico)
        try container.encode(self.cap, forKey: .cap)
        try container.encode(self.comune, forKey: .comune)
        try container.encodeIfPresent(self.provincia, forKey: .provincia)
        try container.encode(self.nazione, forKey: .nazione)
    }
}

public struct Anagrafica: Codable {
    public var denominazione: String?
    public var nome: String?
    public var cognome: String?
    public var codEORI: String?
    public var titolo: String?
    
    public var anagrafica: String {
        if let value = self.denominazione{
            return value
        }
        return [self.nome, self.cognome].compactMap { $0 }.joined(separator: " ")
    }
    
    public init(denominazione: String?, nome: String?, cognome: String?, codEORI: String?, titolo: String?) {
        self.denominazione = denominazione
        self.nome = nome
        self.cognome = cognome
        self.codEORI = codEORI
        self.titolo = titolo
    }

    enum CodingKeys: String, CodingKey{
        case denominazione = "denominazione"
        case nome = "nome"
        case cognome = "cognome"
        case codEORI = "codeori"
        case titolo = "titolo"
    }

    enum EncodableKeys: String, CodingKey {
        case denominazione = "Denominazione"
        case nome = "Nome"
        case cognome = "Cognome"
        case codEORI = "CodEORI"
        case titolo = "Titolo"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.denominazione, forKey: .denominazione)
        try container.encodeIfPresent(self.nome, forKey: .nome)
        try container.encodeIfPresent(self.cognome, forKey: .cognome)
        try container.encodeIfPresent(self.codEORI, forKey: .codEORI)
        try container.encodeIfPresent(self.titolo, forKey: .titolo)
    }
}

public struct IDFiscale: Codable {
    public var idPaese: String
    public var idCodice: String
    
    public init(idPaese: String, idCodice: String) {
        self.idPaese = idPaese
        self.idCodice = idCodice
    }

    enum CodingKeys: String, CodingKey{
        case idPaese = "idpaese"
        case idCodice = "idcodice"
    }

    enum EncodableKeys: String, CodingKey {
        case idPaese = "IdPaese"
        case idCodice = "IdCodice"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.idPaese, forKey: .idPaese)
        try container.encode(self.idCodice, forKey: .idCodice)
    }
}

public enum Natura: String, Codable {
    case ESCLUSE = "N1"
   
    case NONSOGGETTEADIVA = "N2.1"
    case NONSOGGETTEALTRICASI = "N2.2"
    case NONIMPONIBILIESPORTAZIONI = "N3.1"
    case NONIMPONIBILICESSIONINTRACOMUNITARIE = "N3.2"
    case NONIMPONIBILIVERSOSANMARINO = "N3.3"
    case NONIMPONIBILIOPERAZIONIASSIMILATE = "N3.4"
    case NONIMPONIBILIASEGUITODIDICHIARAZIONI = "N3.5"
    case NONIMPONIBILIALTREOPERAZIONI = "N3.6"
    case ESENTI = "N4"
    case REGIMEDELMARGINE = "N5"
    case INVERSIONECONTABILEROTTAMI = "N6.1"
    case INVERSIONECONTABILEOROARGENTO = "N6.2"
    case INVERSIONECONTABILESUBAPPALTODILE = "N6.3"
    case INVERSIONECONTABICESSIONEFABBRICATI = "N6.4"
    case INVERSIONECONTABILECESSIONECELLULARI = "N6.5"
    case INVERSIONECONTABILECESSIONEPRODOTTIELETTRONICI = "N6.6"
    case INVERSIONECONTABILEPRESTAZIONICOMPARTOEDILE = "N6.7"
    case INVERSIONECONTABILESETTORENERGETICO = "N6.8"
    case INVERSIONECONTABILEALTRICASI = "N6.9"
    case IVAASSOLTA = "N7"
    
    @available(*, deprecated, message: "NON PIU VALIDO DAL GENNAIO 2021")
    case NONSOGGETTE = "N2"
    @available(*, deprecated, message: "NON PIU VALIDO DAL GENNAIO 2021")
    case NONIMPONIBILI = "N3"
    @available(*, deprecated, message: "NON PIU VALIDO DAL GENNAIO 2021")
    case INVERSIONECONTABILE = "N6"


}

// MARK: - <FatturaElettronica>
public struct FatturaElettronica: Codable {
    
    public var fatturaElettronicaHeader: FatturaElettronicaHeader
    public var fatturaElettronicaBody: FatturaElettronicaBody

    public init(fatturaElettronicaHeader: FatturaElettronicaHeader, fatturaElettronicaBody: FatturaElettronicaBody) {
        self.fatturaElettronicaHeader = fatturaElettronicaHeader
        self.fatturaElettronicaBody = fatturaElettronicaBody
    }

    enum CodingKeys: String, CodingKey{
        case fatturaElettronicaHeader = "fatturaelettronicaheader"
        case fatturaElettronicaBody = "fatturaelettronicabody"
    }

    enum EncodableKeys: String, CodingKey {
        case fatturaElettronicaHeader = "FatturaElettronicaHeader"
        case fatturaElettronicaBody = "FatturaElettronicaBody"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.fatturaElettronicaHeader, forKey: .fatturaElettronicaHeader)
        try container.encode(self.fatturaElettronicaBody, forKey: .fatturaElettronicaBody)
    }
}


// MARK: - 1 <FatturaElettronicaHeader>
public struct FatturaElettronicaHeader: Codable {
    public var datiTrasmissione: DatiTrasmissione
    public var cedentePrestatore: CedentePrestatore
    public var rappresentanteFiscale: RappresentanteFiscale?
    public var cessionarioCommittente: CessionarioCommittente
    public var terzoIntermediarioOSoggettoEmittente: TerzoIntermediarioSoggettoEmittente?
    public var soggettoEmittente: SoggettoEmittente?
    
    public init(datiTrasmissione: DatiTrasmissione, cedentePrestatore: CedentePrestatore, rappresentanteFiscale: RappresentanteFiscale?, cessionarioCommittente: CessionarioCommittente, terzoIntermediarioOSoggettoEmittente: TerzoIntermediarioSoggettoEmittente?, soggettoEmittente: SoggettoEmittente?) {
        self.datiTrasmissione = datiTrasmissione
        self.cedentePrestatore = cedentePrestatore
        self.rappresentanteFiscale = rappresentanteFiscale
        self.cessionarioCommittente = cessionarioCommittente
        self.terzoIntermediarioOSoggettoEmittente = terzoIntermediarioOSoggettoEmittente
        self.soggettoEmittente = soggettoEmittente
    }

    enum CodingKeys: String, CodingKey{
        case datiTrasmissione = "datitrasmissione"
        case cedentePrestatore = "cedenteprestatore"
        case rappresentanteFiscale = "rappresentantefiscale"
        case cessionarioCommittente = "cessionariocommittente"
        case terzoIntermediarioOSoggettoEmittente = "terzointermediarioosoggettoemittente"
        case soggettoEmittente = "soggettoemittente"
    }

    enum EncodableKeys: String, CodingKey {
        case datiTrasmissione = "DatiTrasmissione"
        case cedentePrestatore = "CedentePrestatore"
        case rappresentanteFiscale = "RappresentanteFiscale"
        case cessionarioCommittente = "CessionarioCommittente"
        case terzoIntermediarioOSoggettoEmittente = "TerzoIntermediarioOSoggettoEmittente"
        case soggettoEmittente = "SoggettoEmittente"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.datiTrasmissione, forKey: .datiTrasmissione)
        try container.encode(self.cedentePrestatore, forKey: .cedentePrestatore)
        try container.encodeIfPresent(self.rappresentanteFiscale, forKey: .rappresentanteFiscale)
        try container.encode(self.cessionarioCommittente, forKey: .cessionarioCommittente)
        try container.encodeIfPresent(self.terzoIntermediarioOSoggettoEmittente, forKey: .terzoIntermediarioOSoggettoEmittente)
        try container.encodeIfPresent(self.soggettoEmittente, forKey: .soggettoEmittente)
    }
}

// MARK: - 1.1 <DatiTrasmissione>
public struct DatiTrasmissione: Codable {
    public var idTrasmittente: IDFiscale
    public var progressivoInvio: String
    public var formatoTrasmissione: FormatoTrasmissione
    public var codiceDestinatario: String
    public var contattiTrasmittente: ContattiTrasmittente?
    public var pecDestinatario: String?
    
    public init(idTrasmittente: IDFiscale, progressivoInvio: String, formatoTrasmissione: FormatoTrasmissione, codiceDestinatario: String, contattiTrasmittente: ContattiTrasmittente?, pecDestinatario: String?) {
        self.idTrasmittente = idTrasmittente
        self.progressivoInvio = progressivoInvio
        self.formatoTrasmissione = formatoTrasmissione
        self.codiceDestinatario = codiceDestinatario
        self.contattiTrasmittente = contattiTrasmittente
        self.pecDestinatario = pecDestinatario
    }

    enum CodingKeys: String, CodingKey{
        case idTrasmittente = "idtrasmittente"
        case progressivoInvio = "progressivoinvio"
        case formatoTrasmissione = "formatotrasmissione"
        case codiceDestinatario = "codicedestinatario"
        case contattiTrasmittente = "contattitrasmittente"
        case pecDestinatario = "pecdestinatario"
    }

    enum EncodableKeys: String, CodingKey {
        case idTrasmittente = "IdTrasmittente"
        case progressivoInvio = "ProgressivoInvio"
        case formatoTrasmissione = "FormatoTrasmissione"
        case codiceDestinatario = "CodiceDestinatario"
        case contattiTrasmittente = "ContattiTrasmittente"
        case pecDestinatario = "PECDestinatario"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.idTrasmittente, forKey: .idTrasmittente)
        try container.encode(self.progressivoInvio, forKey: .progressivoInvio)
        try container.encode(self.formatoTrasmissione, forKey: .formatoTrasmissione)
        try container.encode(self.codiceDestinatario, forKey: .codiceDestinatario)
        try container.encodeIfPresent(self.contattiTrasmittente, forKey: .contattiTrasmittente)
        try container.encodeIfPresent(self.pecDestinatario, forKey: .pecDestinatario)
    }
}

public enum FormatoTrasmissione: String, Codable {
    case FATTURAPA = "FPA12"
    case FATTURAPRIVATI = "FPR12"
}

public struct ContattiTrasmittente: Codable {
    public var telefono: String?
    public var email: String?
    
    public init(telefono: String?, email: String?) {
        self.telefono = telefono
        self.email = email
    }

    enum CodingKeys: String, CodingKey{
        case telefono = "telefono"
        case email = "email"
    }

    enum EncodableKeys: String, CodingKey {
        case telefono = "Telefono"
        case email = "Email"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.telefono, forKey: .telefono)
        try container.encodeIfPresent(self.email, forKey: .email)
    }
}

// MARK: - 1.2 <CedentePrestatore>
public struct CedentePrestatore: Codable {
    public var datiAnagrafici: CedentePrestatoreDatiAnagrafici
    public var sede: Indirizzo
    public var stabileOrganizzazione: Indirizzo?
    public var iscrizioneREA: IscrizioneREA?
    public var contatti: Contatti?
    public var riferimentoAmministrazione: String?
    
    public init(datiAnagrafici: CedentePrestatoreDatiAnagrafici, sede: Indirizzo, stabileOrganizzazione: Indirizzo?, iscrizioneREA: IscrizioneREA?, contatti: Contatti?, riferimentoAmministrazione: String?) {
        self.datiAnagrafici = datiAnagrafici
        self.sede = sede
        self.stabileOrganizzazione = stabileOrganizzazione
        self.iscrizioneREA = iscrizioneREA
        self.contatti = contatti
        self.riferimentoAmministrazione = riferimentoAmministrazione
    }

    enum CodingKeys: String, CodingKey{
        case datiAnagrafici = "datianagrafici"
        case sede = "sede"
        case stabileOrganizzazione = "stabileorganizzazione"
        case iscrizioneREA = "iscrizionerea"
        case contatti = "contatti"
        case riferimentoAmministrazione = "riferimentoamministrazione"
    }

    enum EncodableKeys: String, CodingKey {
        case datiAnagrafici = "DatiAnagrafici"
        case sede = "Sede"
        case stabileOrganizzazione = "StabileOrganizzazione"
        case iscrizioneREA = "IscrizioneREA"
        case contatti = "Contatti"
        case riferimentoAmministrazione = "RiferimentoAmministrazione"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.datiAnagrafici, forKey: .datiAnagrafici)
        try container.encode(self.sede, forKey: .sede)
        try container.encodeIfPresent(self.stabileOrganizzazione, forKey: .stabileOrganizzazione)
        try container.encodeIfPresent(self.iscrizioneREA, forKey: .iscrizioneREA)
        try container.encodeIfPresent(self.contatti, forKey: .contatti)
        try container.encodeIfPresent(self.riferimentoAmministrazione, forKey: .riferimentoAmministrazione)
    }
}

public struct CedentePrestatoreDatiAnagrafici: Codable {
    public var idFiscaleIva: IDFiscale
    public var anagrafica: Anagrafica
    public var regimeFiscale: RegimeFiscale
    public var codiceFiscale: String?
    public var alboProfessionale: String?
    public var provinciaAlbo: String?
    public var numeroIscrizioneAlbo: String?
    public var dataIscrizioAlbo: String?
    
    public init(idFiscaleIva: IDFiscale, anagrafica: Anagrafica, regimeFiscale: RegimeFiscale, codiceFiscale: String?, alboProfessionale: String?, provinciaAlbo: String?, numeroIscrizioneAlbo: String?, dataIscrizioAlbo: String?) {
        self.idFiscaleIva = idFiscaleIva
        self.anagrafica = anagrafica
        self.regimeFiscale = regimeFiscale
        self.codiceFiscale = codiceFiscale
        self.alboProfessionale = alboProfessionale
        self.provinciaAlbo = provinciaAlbo
        self.numeroIscrizioneAlbo = numeroIscrizioneAlbo
        self.dataIscrizioAlbo = dataIscrizioAlbo
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case anagrafica = "anagrafica"
        case regimeFiscale = "regimefiscale"
        case provinciaAlbo = "provinciaalbo"
        case codiceFiscale = "codicefiscale"
        case alboProfessionale = "alboprofessionale"
        case numeroIscrizioneAlbo = "numeroiscrizionealbo"
        case dataIscrizioAlbo = "dataiscrizioalbo" 
    }

    enum EncodableKeys: String, CodingKey {
        case idFiscaleIva = "IdFiscaleIVA"
        case anagrafica = "Anagrafica"
        case regimeFiscale = "RegimeFiscale"
        case codiceFiscale = "CodiceFiscale"
        case alboProfessionale = "AlboProfessionale"
        case provinciaAlbo = "ProvinciaAlbo"
        case numeroIscrizioneAlbo = "NumeroIscrizioneAlbo"
        case dataIscrizioAlbo = "DataIscrizioneAlbo"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.idFiscaleIva, forKey: .idFiscaleIva)
        try container.encode(self.anagrafica, forKey: .anagrafica)
        try container.encode(self.regimeFiscale, forKey: .regimeFiscale)
        try container.encodeIfPresent(self.codiceFiscale, forKey: .codiceFiscale)
        try container.encodeIfPresent(self.alboProfessionale, forKey: .alboProfessionale)
        try container.encodeIfPresent(self.provinciaAlbo, forKey: .provinciaAlbo)
        try container.encodeIfPresent(self.numeroIscrizioneAlbo, forKey: .numeroIscrizioneAlbo)
        try container.encodeIfPresent(self.dataIscrizioAlbo, forKey: .dataIscrizioAlbo)
    }
}

public struct IscrizioneREA: Codable {
    public var ufficio : String
    public var numeroREA: String
    public var capitaleSociale: Double?
    public var socioUnico: SocioUnico?
    public var statoLiquidazione: StatoLiquidazione
    
    public init(ufficio: String, numeroREA: String, capitaleSociale: Double?, socioUnico: SocioUnico?, statoLiquidazione: StatoLiquidazione) {
        self.ufficio = ufficio
        self.numeroREA = numeroREA
        self.capitaleSociale = capitaleSociale
        self.socioUnico = socioUnico
        self.statoLiquidazione = statoLiquidazione
    }

    enum CodingKeys: String, CodingKey{
        case ufficio = "ufficio"
        case numeroREA =  "numerorea"
        case capitaleSociale = "capitalesociale"
        case socioUnico = "sociounico"
        case statoLiquidazione = "statoliquidazione"
    }

    enum EncodableKeys: String, CodingKey {
        case ufficio = "Ufficio"
        case numeroREA = "NumeroREA"
        case capitaleSociale = "CapitaleSociale"
        case socioUnico = "SocioUnico"
        case statoLiquidazione = "StatoLiquidazione"
    }
}

public enum StatoLiquidazione: String, Codable {
    case INLIQUIDAZIONE = "LS"
    case NONINLIQUIDAZIONE = "LN"
}

public enum SocioUnico: String, Codable {
    case SOCIOUNICO = "SU"
    case PIUSOCI = "SM"
}

public struct Contatti: Codable {
    public var telefono : String?
    public var fax: String?
    public var email: String?
    
    public init(telefono: String?, fax: String?, email: String?) {
        self.telefono = telefono
        self.fax = fax
        self.email = email
    }

    enum CodingKeys: String, CodingKey{
        case telefono = "telefono"
        case fax =  "fax"
        case email = "email"
    }

    enum EncodableKeys: String, CodingKey {
        case telefono = "Telefono"
        case fax = "Fax"
        case email = "Email"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.telefono, forKey: .telefono)
        try container.encodeIfPresent(self.fax, forKey: .fax)
        try container.encodeIfPresent(self.email, forKey: .email)
    }
}

public enum RegimeFiscale: String, Codable {
    case RF01 = "RF01"
    case RF02 = "RF02"
    case RF03 = "RF03"
    case RF04 = "RF04"
    case RF05 = "RF05"
    case RF06 = "RF06"
    case RF07 = "RF07"
    case RF08 = "RF08"
    case RF09 = "RF09"
    case RF10 = "RF10"
    case RF11 = "RF11"
    case RF12 = "RF12"
    case RF13 = "RF13"
    case RF14 = "RF14"
    case RF15 = "RF15"
    case RF16 = "RF16"
    case RF17 = "RF17"
    case RF18 = "RF18"
    case RF19 = "RF19"
    
}

// MARK: - 1.3 <RappresentateFiscale>
public struct RappresentanteFiscale: Codable {
    public var datiAnagrafici: DatiAnagraficiRappresentante
    
    public init(datiAnagrafici: DatiAnagraficiRappresentante) {
        self.datiAnagrafici = datiAnagrafici
    }

    enum CodingKeys: String, CodingKey{
        case datiAnagrafici = "datianagrafici"
    }

    enum EncodableKeys: String, CodingKey {
        case datiAnagrafici = "DatiAnagrafici"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.datiAnagrafici, forKey: .datiAnagrafici)
    }
}

public struct DatiAnagraficiRappresentante: Codable {
    public var idFiscaleIva: IDFiscale
    public var codiceFiscale: String?
    public var anagrafica: Anagrafica
    
    public init(idFiscaleIva: IDFiscale, codiceFiscale: String?, anagrafica: Anagrafica) {
        self.idFiscaleIva = idFiscaleIva
        self.codiceFiscale = codiceFiscale
        self.anagrafica = anagrafica
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case codiceFiscale = "codicefiscale"
        case anagrafica = "anagrafica"
    }

    enum EncodableKeys: String, CodingKey {
        case idFiscaleIva = "IdFiscaleIVA"
        case codiceFiscale = "CodiceFiscale"
        case anagrafica = "Anagrafica"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.idFiscaleIva, forKey: .idFiscaleIva)
        try container.encodeIfPresent(self.codiceFiscale, forKey: .codiceFiscale)
        try container.encode(self.anagrafica, forKey: .anagrafica)
    }
}

// MARK: - 1.4 <CessionarioCommittente>
public struct CessionarioCommittente: Codable {
    public var datiAnagrafici: CessionarioCommittenteDatiAnagrafici
    public var sede: Indirizzo
    public var stabileOrganizzazione: Indirizzo?
    public var rappresentanteFiscale: CessionarioCommittenteRappresentanteFiscale?
    
    public init(datiAnagrafici: CessionarioCommittenteDatiAnagrafici, sede: Indirizzo, stabileOrganizzazione: Indirizzo?, rappresentanteFiscale: CessionarioCommittenteRappresentanteFiscale?) {
        self.datiAnagrafici = datiAnagrafici
        self.sede = sede
        self.stabileOrganizzazione = stabileOrganizzazione
        self.rappresentanteFiscale = rappresentanteFiscale
    }
    
    enum CodingKeys: String, CodingKey{
        case datiAnagrafici = "datianagrafici"
        case sede = "sede"
        case stabileOrganizzazione = "stabileorganizzazione"
        case rappresentanteFiscale = "rappresentantefiscale"
    }

    enum EncodableKeys: String, CodingKey {
        case datiAnagrafici = "DatiAnagrafici"
        case sede = "Sede"
        case stabileOrganizzazione = "StabileOrganizzazione"
        case rappresentanteFiscale = "RappresentanteFiscale"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.datiAnagrafici, forKey: .datiAnagrafici)
        try container.encode(self.sede, forKey: .sede)
        try container.encodeIfPresent(self.stabileOrganizzazione, forKey: .stabileOrganizzazione)
        try container.encodeIfPresent(self.rappresentanteFiscale, forKey: .rappresentanteFiscale)
    }
}

public struct CessionarioCommittenteDatiAnagrafici: Codable {
    public var idFiscaleIva: IDFiscale?
    public var codiceFiscale: String?
    public var anagrafica: Anagrafica
    
    public init(idFiscaleIva: IDFiscale?, codiceFiscale: String?, anagrafica: Anagrafica) {
        self.idFiscaleIva = idFiscaleIva
        self.codiceFiscale = codiceFiscale
        self.anagrafica = anagrafica
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case codiceFiscale = "codicefiscale"
        case anagrafica = "anagrafica"
    }

    enum EncodableKeys: String, CodingKey {
        case idFiscaleIva = "IdFiscaleIVA"
        case codiceFiscale = "CodiceFiscale"
        case anagrafica = "Anagrafica"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.idFiscaleIva, forKey: .idFiscaleIva)
        try container.encodeIfPresent(self.codiceFiscale, forKey: .codiceFiscale)
        try container.encode(self.anagrafica, forKey: .anagrafica)
    }
}

public struct CessionarioCommittenteRappresentanteFiscale: Codable {
    public var idFiscaleIva: IDFiscale
    public var denominazione: String?
    public var nome: String?
    public var cognome: String?
    
    public init(idFiscaleIva: IDFiscale, denominazione: String?, nome: String?, cognome: String?) {
        self.idFiscaleIva = idFiscaleIva
        self.denominazione = denominazione
        self.nome = nome
        self.cognome = cognome
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case denominazione = "denominazione"
        case nome = "nome"
        case cognome = "cognome"
    }

    enum EncodableKeys: String, CodingKey {
        case idFiscaleIva = "IdFiscaleIVA"
        case denominazione = "Denominazione"
        case nome = "Nome"
        case cognome = "Cognome"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.idFiscaleIva, forKey: .idFiscaleIva)
        try container.encodeIfPresent(self.denominazione, forKey: .denominazione)
        try container.encodeIfPresent(self.nome, forKey: .nome)
        try container.encodeIfPresent(self.cognome, forKey: .cognome)
    }
}

// MARK: - 1.5 <TerzoIntermediarioOSoggettoEmittente>
public struct TerzoIntermediarioSoggettoEmittente: Codable {
    public var datiAnagrafici: DatiAnagraficiTerzoIntermediario
    
    public init(datiAnagrafici: DatiAnagraficiTerzoIntermediario) {
        self.datiAnagrafici = datiAnagrafici
    }

    enum CodingKeys: String, CodingKey{
        case datiAnagrafici = "datianagrafici"
    }

    enum EncodableKeys: String, CodingKey {
        case datiAnagrafici = "DatiAnagrafici"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.datiAnagrafici, forKey: .datiAnagrafici)
    }
}

public struct DatiAnagraficiTerzoIntermediario: Codable {
    public var idFiscaleIva: IDFiscale?
    public var codiceFiscale: String?
    public var anagrafica: Anagrafica
    
    public init(idFiscaleIva: IDFiscale?, codiceFiscale: String?, anagrafica: Anagrafica) {
        self.idFiscaleIva = idFiscaleIva
        self.codiceFiscale = codiceFiscale
        self.anagrafica = anagrafica
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case codiceFiscale = "codicefiscale"
        case anagrafica = "anagrafica"
    }

    enum EncodableKeys: String, CodingKey {
        case idFiscaleIva = "IdFiscaleIVA"
        case codiceFiscale = "CodiceFiscale"
        case anagrafica = "Anagrafica"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.idFiscaleIva, forKey: .idFiscaleIva)
        try container.encodeIfPresent(self.codiceFiscale, forKey: .codiceFiscale)
        try container.encode(self.anagrafica, forKey: .anagrafica)
    }
}

// MARK: - 1.6 <SoggettoEmittente>
public enum SoggettoEmittente: String, Codable {
    case TERZO = "TZ"
    case CESSIONARIOCOMMITTENTE = "CC"
}

// MARK: - 2 <FatturaElettronicaBody>
public struct FatturaElettronicaBody: Codable {
    
    public var datiGenerali: DatiGenerali
    public var datiBeniServizi: DatiBeniServizi
    public var datiVeicoli: DatiVeicoli?
    public var datiPagamento: [DatiPagamento] = []
    public var allegati: [Allegati]?
    
    public init(datiGenerali: DatiGenerali, datiBeniServizi: DatiBeniServizi, datiVeicoli: DatiVeicoli?, datiPagamento: [DatiPagamento] = [], allegati: [Allegati]?) {
        self.datiGenerali = datiGenerali
        self.datiBeniServizi = datiBeniServizi
        self.datiVeicoli = datiVeicoli
        self.datiPagamento = datiPagamento
        self.allegati = allegati
    }
    
    enum CodingKeys: String, CodingKey{
        case allegati = "allegati"
        case datiPagamento = "datipagamento"
        case datiGenerali = "datigenerali"
        case datiBeniServizi = "datibeniservizi"
        case datiVeicoli = "dativeicoli"
    }

    enum EncodableKeys: String, CodingKey {
        case allegati = "Allegati"
        case datiPagamento = "DatiPagamento"
        case datiGenerali = "DatiGenerali"
        case datiBeniServizi = "DatiBeniServizi"
        case datiVeicoli = "DatiVeicoli"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.allegati, forKey: .allegati)
        try container.encode(self.datiPagamento, forKey: .datiPagamento)
        try container.encode(self.datiGenerali, forKey: .datiGenerali)
        try container.encode(self.datiBeniServizi, forKey: .datiBeniServizi)
        try container.encodeIfPresent(self.datiVeicoli, forKey: .datiVeicoli)
    }
}

// MARK: - 2.1 <DatiGenerali>
public struct DatiGenerali: Codable {
    public var datiGeneraliDocumento: DatiGeneraliDocumento
    public var datiOrdineAcquisto: [DatiDocumentiCorrelati]?
    public var datiContratto: [DatiDocumentiCorrelati]?
    public var datiConvenzione: [DatiDocumentiCorrelati]?
    public var datiRicezione: [DatiDocumentiCorrelati]?
    public var datiFattureCollegate: [DatiDocumentiCorrelati]?
    public var datiSal: [DatiSAL]?
    public var datiDdt: [DatiDDT]?
    public var datiTrasporto: DatiTrasporto?
    public var fatturaPrincipale: FatturaPrincipale?
    
    public init(datiGeneraliDocumento: DatiGeneraliDocumento, datiOrdineAcquisto: [DatiDocumentiCorrelati]?, datiContratto: [DatiDocumentiCorrelati]?, datiConvenzione: [DatiDocumentiCorrelati]?, datiRicezione: [DatiDocumentiCorrelati]?, datiFattureCollegate: [DatiDocumentiCorrelati]?, datiSal: [DatiSAL]?, datiDdt: [DatiDDT]?, datiTrasporto: DatiTrasporto?, fatturaPrincipale: FatturaPrincipale?) {
        self.datiGeneraliDocumento = datiGeneraliDocumento
        self.datiOrdineAcquisto = datiOrdineAcquisto
        self.datiContratto = datiContratto
        self.datiConvenzione = datiConvenzione
        self.datiRicezione = datiRicezione
        self.datiFattureCollegate = datiFattureCollegate
        self.datiSal = datiSal
        self.datiDdt = datiDdt
        self.datiTrasporto = datiTrasporto
        self.fatturaPrincipale = fatturaPrincipale
    }
    
    enum CodingKeys: String, CodingKey{
        case datiGeneraliDocumento = "datigeneralidocumento"
        case datiOrdineAcquisto = "datiordineacquisto"
        case datiContratto = "daticontratto"
        case datiConvenzione = "daticonvenzione"
        case datiRicezione = "datiricezione"
        case datiFattureCollegate = "datifatturecollegate"
        case datiSal = "datisal"
        case datiDdt = "datiddt"
        case datiTrasporto = "datitrasporto"
        case fatturaPrincipale = "fatturaprincipale"
    }

    enum EncodableKeys: String, CodingKey {
        case datiGeneraliDocumento = "DatiGeneraliDocumento"
        case datiOrdineAcquisto = "DatiOrdineAcquisto"
        case datiContratto = "DatiContratto"
        case datiConvenzione = "DatiConvenzione"
        case datiRicezione = "DatiRicezione"
        case datiFattureCollegate = "DatiFattureCollegate"
        case datiSal = "DatiSAL"
        case datiDdt = "DatiDDT"
        case datiTrasporto = "DatiTrasporto"
        case fatturaPrincipale = "FatturaPrincipale"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.datiGeneraliDocumento, forKey: .datiGeneraliDocumento)
        try container.encodeIfPresent(self.datiOrdineAcquisto, forKey: .datiOrdineAcquisto)
        try container.encodeIfPresent(self.datiContratto, forKey: .datiContratto)
        try container.encodeIfPresent(self.datiConvenzione, forKey: .datiConvenzione)
        try container.encodeIfPresent(self.datiRicezione, forKey: .datiRicezione)
        try container.encodeIfPresent(self.datiFattureCollegate, forKey: .datiFattureCollegate)
        try container.encodeIfPresent(self.datiSal, forKey: .datiSal)
        try container.encodeIfPresent(self.datiDdt, forKey: .datiDdt)
        try container.encodeIfPresent(self.datiTrasporto, forKey: .datiTrasporto)
        try container.encodeIfPresent(self.fatturaPrincipale, forKey: .fatturaPrincipale)
    }
}

public struct DatiGeneraliDocumento: Codable {
    public var tipoDocumento: TipoDocumento
    public var divisa: String
    public var data: Date
    public var numero: String
    public var datiRitenuta: [DatiRitenuta]?
    public var datiBollo: DatiBollo?
    public var datiCassaPrevidenziale: [DatiCassaPrevidenziale]?
    public var scontoMaggiorazione: [ScontoMaggiorazione]?
    public var importoTotaleDocumento: Double?
    public var arrotondamento: Double?
    public var causale: [String]?
    public var art73: String?
    
    public init(tipoDocumento: TipoDocumento, divisa: String, data: Date, numero: String, datiRitenuta: [DatiRitenuta]?, datiBollo: DatiBollo?, datiCassaPrevidenziale: [DatiCassaPrevidenziale]?, scontoMaggiorazione: [ScontoMaggiorazione]?, importoTotaleDocumento: Double?, arrotondamento: Double?, causale: [String]?, art73: String?) {
        self.tipoDocumento = tipoDocumento
        self.divisa = divisa
        self.data = data
        self.numero = numero
        self.datiRitenuta = datiRitenuta
        self.datiBollo = datiBollo
        self.datiCassaPrevidenziale = datiCassaPrevidenziale
        self.scontoMaggiorazione = scontoMaggiorazione
        self.importoTotaleDocumento = importoTotaleDocumento
        self.arrotondamento = arrotondamento
        self.causale = causale
        self.art73 = art73
    }
    
    enum CodingKeys: String, CodingKey {
        case tipoDocumento = "tipodocumento"
        case divisa = "divisa"
        case data = "data"
        case numero = "numero"
        case datiRitenuta = "datiritenuta"
        case datiBollo = "datibollo"
        case datiCassaPrevidenziale = "daticassaprevidenziale"
        case scontoMaggiorazione = "scontomaggiorazione"
        case importoTotaleDocumento = "importototaledocumento"
        case arrotondamento = "arrotondamento"
        case causale = "causale"
        case art73 = "art73"
    }

    enum EncodableKeys: String, CodingKey {
        case tipoDocumento = "TipoDocumento"
        case divisa = "Divisa"
        case data = "Data"
        case numero = "Numero"
        case datiRitenuta = "DatiRitenuta"
        case datiBollo = "DatiBollo"
        case datiCassaPrevidenziale = "DatiCassaPrevidenziale"
        case scontoMaggiorazione = "ScontoMaggiorazione"
        case importoTotaleDocumento = "ImportoTotaleDocumento"
        case arrotondamento = "Arrotondamento"
        case causale = "Causale"
        case art73 = "Art73"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.tipoDocumento, forKey: .tipoDocumento)
        try container.encode(self.divisa, forKey: .divisa)
        try container.encode(self.data, forKey: .data)
        try container.encode(self.numero, forKey: .numero)
        try container.encodeIfPresent(self.datiRitenuta, forKey: .datiRitenuta)
        try container.encodeIfPresent(self.datiBollo, forKey: .datiBollo)
        try container.encodeIfPresent(self.datiCassaPrevidenziale, forKey: .datiCassaPrevidenziale)
        try container.encodeIfPresent(self.scontoMaggiorazione, forKey: .scontoMaggiorazione)
        try container.encodeIfPresent(self.importoTotaleDocumento, forKey: .importoTotaleDocumento)
        try container.encodeIfPresent(self.arrotondamento, forKey: .arrotondamento)
        try container.encodeIfPresent(self.causale, forKey: .causale)
        try container.encodeIfPresent(self.art73, forKey: .art73)
    }

}

public enum TipoDocumento: String, Codable {
    case FATTURA = "TD01"
    case ACCONTOSUFATTURA = "TD02"
    case ACCONTOSUPARCELLA = "TD03"
    case NOTADICREDITO = "TD04"
    case NOTADIDEBITO = "TD05"
    case PARCELLA = "TD06"
    case TD16 = "TD16"
    case TD17 = "TD17"
    case TD19 = "TD19"
    case TD20 = "TD20"
    case TD21 = "TD21"
    case TD22 = "TD22"
    case TD23 = "TD23"
    case TD24 = "TD24"
    case TD25 = "TD25"
    case TD26 = "TD26"
    case TD27 = "TD27"
    // Mark: - Fattura Elettronica v 1.3.2
    case TD28 = "TD28"
}

public struct DatiRitenuta: Codable {
    public var tipoRitenuta: TipoRitenuta
    public var importoRitenuta: Double
    public var aliquotaRitenuta: Double
    public var causalePagamento: CausalePagamento
    
    public init(tipoRitenuta: TipoRitenuta, importoRitenuta: Double, aliquotaRitenuta: Double, causalePagamento: CausalePagamento) {
        self.tipoRitenuta = tipoRitenuta
        self.importoRitenuta = importoRitenuta
        self.aliquotaRitenuta = aliquotaRitenuta
        self.causalePagamento = causalePagamento
    }
    
    enum CodingKeys: String, CodingKey{
        case tipoRitenuta = "tiporitenuta"
        case importoRitenuta = "importoritenuta"
        case aliquotaRitenuta = "aliquotaritenuta"
        case causalePagamento = "causalepagamento"
    }

    enum EncodableKeys: String, CodingKey {
        case tipoRitenuta = "TipoRitenuta"
        case importoRitenuta = "ImportoRitenuta"
        case aliquotaRitenuta = "AliquotaRitenuta"
        case causalePagamento = "CausalePagamento"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.tipoRitenuta, forKey: .tipoRitenuta)
        try container.encode(self.importoRitenuta, forKey: .importoRitenuta)
        try container.encode(self.aliquotaRitenuta, forKey: .aliquotaRitenuta)
        try container.encode(self.causalePagamento, forKey: .causalePagamento)
    }
}

public enum TipoRitenuta: String, Codable {
    case RT01 = "RT01"
    case RT02 = "RT02"
    case RT03 = "RT03"
    case RT04 = "RT04"
    case RT05 = "RT05"
    case RT06 = "RT06"
}

public enum CausalePagamento: String, Codable {
    case A = "A"
    case B = "B"
    case C = "C"
    case D = "D"
    case E = "E"
    case G = "G"
    case H = "H"
    case I = "I"
    case L = "L"
    case M = "M"
    case N = "N"
    case O = "O"
    case P = "P"
    case Q = "Q"
    case R = "R"
    case S = "S"
    case T = "T"
    case U = "U"
    case V = "V"
    case W = "W"
    case X = "X"
    case Y = "Y"
    case Z = "Z"
    case L1 = "L1"
    case M1 = "M1"
    case O1 = "O1"
    case V1 = "V1"
}

public struct DatiBollo: Codable {
    public var bolloVirtuale: String
    public var importoBollo: Double?
    
    public init(bolloVirtuale: String, importoBollo: Double?) {
        self.bolloVirtuale = bolloVirtuale
        self.importoBollo = importoBollo
    }
    
    enum CodingKeys: String, CodingKey{
        case bolloVirtuale = "bollovirtuale"
        case importoBollo = "importobollo"
    }

    enum EncodableKeys: String, CodingKey {
        case bolloVirtuale = "BolloVirtuale"
        case importoBollo = "ImportoBollo"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.bolloVirtuale, forKey: .bolloVirtuale)
        try container.encodeIfPresent(self.importoBollo, forKey: .importoBollo)
    }
}

public struct DatiCassaPrevidenziale: Codable {
    public var tipoCassa: TipoCassa
    public var alCassa: Double
    public var importoContributoCassa: Double
    public var imponibileCassa: Double?
    public var aliquotaIVA: Double
    @PABool public var ritenuta: Bool?
    public var natura: Natura?
    public var riferimentoAmministrazione: String?
    
    public init(tipoCassa: TipoCassa, alCassa: Double, importoContributoCassa: Double, imponibileCassa: Double?, aliquotaIVA: Double, ritenuta: Bool?, natura: Natura?, riferimentoAmministrazione: String?) {
        self.tipoCassa = tipoCassa
        self.alCassa = alCassa
        self.importoContributoCassa = importoContributoCassa
        self.imponibileCassa = imponibileCassa
        self.aliquotaIVA = aliquotaIVA
        self.ritenuta = ritenuta
        self.natura = natura
        self.riferimentoAmministrazione = riferimentoAmministrazione
    }
    
    enum CodingKeys: String, CodingKey{
        case tipoCassa = "tipocassa"
        case alCassa = "alcassa"
        case importoContributoCassa = "importocontributocassa"
        case imponibileCassa = "imponibilecassa"
        case aliquotaIVA = "aliquotaiva"
        case ritenuta = "ritenuta"
        case natura = "natura"
        case riferimentoAmministrazione = "riferimentoamministrazione"
    }

    enum EncodableKeys: String, CodingKey {
        case tipoCassa = "TipoCassa"
        case alCassa = "AlCassa"
        case importoContributoCassa = "ImportoContributoCassa"
        case imponibileCassa = "ImponibileCassa"
        case aliquotaIVA = "AliquotaIVA"
        case ritenuta = "Ritenuta"
        case natura = "Natura"
        case riferimentoAmministrazione = "RiferimentoAmministrazione"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.tipoCassa, forKey: .tipoCassa)
        try container.encode(self.alCassa, forKey: .alCassa)
        try container.encode(self.importoContributoCassa, forKey: .importoContributoCassa)
        try container.encodeIfPresent(self.imponibileCassa, forKey: .imponibileCassa)
        try container.encode(self.aliquotaIVA, forKey: .aliquotaIVA)
        try container.encodeIfPresent(self.ritenuta, forKey: .ritenuta)
        try container.encodeIfPresent(self.natura, forKey: .natura)
        try container.encodeIfPresent(self.riferimentoAmministrazione, forKey: .riferimentoAmministrazione)
    }
}

public enum TipoCassa: String, Codable {
    case TC01 = "TC01"
    case TC02 = "TC02"
    case TC03 = "TC03"
    case TC04 = "TC04"
    case TC05 = "TC05"
    case TC06 = "TC06"
    case TC07 = "TC07"
    case TC08 = "TC08"
    case TC09 = "TC09"
    case TC10 = "TC10"
    case TC11 = "TC11"
    case TC12 = "TC12"
    case TC13 = "TC13"
    case TC14 = "TC14"
    case TC15 = "TC15"
    case TC16 = "TC16"
    case TC17 = "TC17"
    case TC18 = "TC18"
    case TC19 = "TC19"
    case TC20 = "TC20"
    case TC21 = "TC21"
    case TC22 = "TC22"
}

public struct ScontoMaggiorazione: Codable {
    public var tipo: TipoScontoMaggiorazione
    public var percentuale: Double?
    public var importo: Double?
    
    public init(tipo: TipoScontoMaggiorazione, percentuale: Double?, importo: Double?) {
        self.tipo = tipo
        self.percentuale = percentuale
        self.importo = importo
    }

    
    enum CodingKeys: String, CodingKey{
        case tipo = "tipo"
        case percentuale = "percentuale"
        case importo = "importo"
    }

    enum EncodableKeys: String, CodingKey {
        case tipo = "Tipo"
        case percentuale = "Percentuale"
        case importo = "Importo"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.tipo, forKey: .tipo)
        try container.encodeIfPresent(self.percentuale, forKey: .percentuale)
        try container.encodeIfPresent(self.importo, forKey: .importo)
    }
}

public enum TipoScontoMaggiorazione: String, Codable {
    case SCONTO = "SC"
    case MAGGIORAZIONE = "MG"
}

public struct DatiDocumentiCorrelati: Codable {
    public var riferimentoNumeroLinea: [Int]?
    public var idDocumento: String
    public var numItem: String?
    public var codiceCup: String?
    public var codiceCig: String?
    public var data: Date?
    public var codiceCommessaConvenzione: String?
    
    public init(riferimentoNumeroLinea: [Int]?, idDocumento: String, numItem: String?, codiceCup: String?, codiceCig: String?, data: Date?, codiceCommessaConvenzione: String?) {
        self.riferimentoNumeroLinea = riferimentoNumeroLinea
        self.idDocumento = idDocumento
        self.numItem = numItem
        self.codiceCup = codiceCup
        self.codiceCig = codiceCig
        self.data = data
        self.codiceCommessaConvenzione = codiceCommessaConvenzione
    }
    
    enum CodingKeys: String, CodingKey{
        case riferimentoNumeroLinea = "riferimentonumerolinea"
        case idDocumento = "iddocumento"
        case numItem = "numitem"
        case codiceCup = "codicecup"
        case codiceCig = "codicecig"
        case data = "data"
        case codiceCommessaConvenzione = "codicecommessaconvenzione"
    }

    enum EncodableKeys: String, CodingKey {
        case riferimentoNumeroLinea = "RiferimentoNumeroLinea"
        case idDocumento = "IdDocumento"
        case numItem = "NumItem"
        case codiceCup = "CodiceCUP"
        case codiceCig = "CodiceCIG"
        case data = "Data"
        case codiceCommessaConvenzione = "CodiceCommessaConvenzione"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.riferimentoNumeroLinea, forKey: .riferimentoNumeroLinea)
        try container.encode(self.idDocumento, forKey: .idDocumento)
        try container.encodeIfPresent(self.numItem, forKey: .numItem)
        try container.encodeIfPresent(self.codiceCup, forKey: .codiceCup)
        try container.encodeIfPresent(self.codiceCig, forKey: .codiceCig)
        try container.encodeIfPresent(self.data, forKey: .data)
        try container.encodeIfPresent(self.codiceCommessaConvenzione, forKey: .codiceCommessaConvenzione)
    }
}

public struct DatiSAL: Codable {
    public var riferimentoFase: Int
    
    public init(riferimentoFase: Int) {
        self.riferimentoFase = riferimentoFase
    }

    
    enum CodingKeys: String, CodingKey{
        case riferimentoFase = "riferimentofase"
    }

    enum EncodableKeys: String, CodingKey {
        case riferimentoFase = "RiferimentoFase"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.riferimentoFase, forKey: .riferimentoFase)
    }
}

public struct DatiDDT: Codable {
    public var numeroDdt: String
    public var dataDdt: Date
    public var riferimentoNumeroLinea: [Int]?
    
    public init(numeroDdt: String, dataDdt: Date, riferimentoNumeroLinea: [Int]?) {
        self.numeroDdt = numeroDdt
        self.dataDdt = dataDdt
        self.riferimentoNumeroLinea = riferimentoNumeroLinea
    }

    
    enum CodingKeys: String, CodingKey{
        case numeroDdt = "numeroddt"
        case dataDdt = "dataddt"
        case riferimentoNumeroLinea = "riferimentonumerolinea"
    }

    enum EncodableKeys: String, CodingKey {
        case numeroDdt = "NumeroDDT"
        case dataDdt = "DataDDT"
        case riferimentoNumeroLinea = "RiferimentoNumeroLinea"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.numeroDdt, forKey: .numeroDdt)
        try container.encode(self.dataDdt, forKey: .dataDdt)
        try container.encodeIfPresent(self.riferimentoNumeroLinea, forKey: .riferimentoNumeroLinea)
    }
}

public struct DatiTrasporto: Codable {
    public var datiAnagraficiVettore: DatiAnagraficiVettore?
    public var mezzoTrasporto: String?
    public var causaleTrasporto: String?
    public var numeroColli: Int?
    public var descrizione: String?
    public var unitaMisuraPeso: String?
    public var pesoLordo: Double?
    public var pesoNetto: Double?
    public var dataOraRitiro: Date?
    public var dataInizioTrasporto: Date?
    public var tipoResa: String?
    public var indirizzoResa: Indirizzo?
    public var dataOraConsegna: Date?
    
    public init(datiAnagraficiVettore: DatiAnagraficiVettore?, mezzoTrasporto: String?, causaleTrasporto: String?, numeroColli: Int?, descrizione: String?, unitaMisuraPeso: String?, pesoLordo: Double?, pesoNetto: Double?, dataOraRitiro: Date?, dataInizioTrasporto: Date?, tipoResa: String?, indirizzoResa: Indirizzo?, dataOraConsegna: Date?) {
        self.datiAnagraficiVettore = datiAnagraficiVettore
        self.mezzoTrasporto = mezzoTrasporto
        self.causaleTrasporto = causaleTrasporto
        self.numeroColli = numeroColli
        self.descrizione = descrizione
        self.unitaMisuraPeso = unitaMisuraPeso
        self.pesoLordo = pesoLordo
        self.pesoNetto = pesoNetto
        self.dataOraRitiro = dataOraRitiro
        self.dataInizioTrasporto = dataInizioTrasporto
        self.tipoResa = tipoResa
        self.indirizzoResa = indirizzoResa
        self.dataOraConsegna = dataOraConsegna
    }

    enum CodingKeys: String, CodingKey{
        case datiAnagraficiVettore = "datianagraficivettore"
        case mezzoTrasporto = "mezzotrasporto"
        case causaleTrasporto = "causaletrasporto"
        case numeroColli = "numerocolli"
        case descrizione = "descrizione"
        case unitaMisuraPeso = "unitamisurapeso"
        case pesoLordo = "pesolordo"
        case pesoNetto = "pesonetto"
        case dataOraRitiro = "dataoraritiro"
        case dataInizioTrasporto = "datainiziotrasporto"
        case tipoResa = "tiporesa"
        case indirizzoResa = "indirizzoresa"
        case dataOraConsegna = "dataoraconsegna"
    }

    enum EncodableKeys: String, CodingKey {
        case datiAnagraficiVettore = "DatiAnagraficiVettore"
        case mezzoTrasporto = "MezzoTrasporto"
        case causaleTrasporto = "CausaleTrasporto"
        case numeroColli = "NumeroColli"
        case descrizione = "Descrizione"
        case unitaMisuraPeso = "UnitaMisuraPeso"
        case pesoLordo = "PesoLordo"
        case pesoNetto = "PesoNetto"
        case dataOraRitiro = "DataOraRitiro"
        case dataInizioTrasporto = "DataInizioTrasporto"
        case tipoResa = "TipoResa"
        case indirizzoResa = "IndirizzoResa"
        case dataOraConsegna = "DataOraConsegna"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.datiAnagraficiVettore, forKey: .datiAnagraficiVettore)
        try container.encodeIfPresent(self.mezzoTrasporto, forKey: .mezzoTrasporto)
        try container.encodeIfPresent(self.causaleTrasporto, forKey: .causaleTrasporto)
        try container.encodeIfPresent(self.numeroColli, forKey: .numeroColli)
        try container.encodeIfPresent(self.descrizione, forKey: .descrizione)
        try container.encodeIfPresent(self.unitaMisuraPeso, forKey: .unitaMisuraPeso)
        try container.encodeIfPresent(self.pesoLordo, forKey: .pesoLordo)
        try container.encodeIfPresent(self.pesoNetto, forKey: .pesoNetto)
        try container.encodeIfPresent(self.dataOraRitiro, forKey: .dataOraRitiro)
        try container.encodeIfPresent(self.dataInizioTrasporto, forKey: .dataInizioTrasporto)
        try container.encodeIfPresent(self.tipoResa, forKey: .tipoResa)
        try container.encodeIfPresent(self.indirizzoResa, forKey: .indirizzoResa)
        try container.encodeIfPresent(self.dataOraConsegna, forKey: .dataOraConsegna)
    }
    
}

public struct DatiAnagraficiVettore: Codable {
    public var idFiscaleIva: IDFiscale
    public var codiceFiscale: String?
    public var anagrafica: Anagrafica
    public var numeroLicenzaGuida: String?
    
    public init(idFiscaleIva: IDFiscale, codiceFiscale: String?, anagrafica: Anagrafica, numeroLicenzaGuida: String?) {
        self.idFiscaleIva = idFiscaleIva
        self.codiceFiscale = codiceFiscale
        self.anagrafica = anagrafica
        self.numeroLicenzaGuida = numeroLicenzaGuida
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case codiceFiscale = "codicefiscale"
        case anagrafica = "anagrafica"
        case numeroLicenzaGuida = "numerolicenzaguida"
    }

    enum EncodableKeys: String, CodingKey {
        case idFiscaleIva = "IdFiscaleIVA"
        case codiceFiscale = "CodiceFiscale"
        case anagrafica = "Anagrafica"
        case numeroLicenzaGuida = "NumeroLicenzaGuida"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.idFiscaleIva, forKey: .idFiscaleIva)
        try container.encodeIfPresent(self.codiceFiscale, forKey: .codiceFiscale)
        try container.encodeIfPresent(self.anagrafica, forKey: .anagrafica)
        try container.encodeIfPresent(self.numeroLicenzaGuida, forKey: .numeroLicenzaGuida)
    }
}

public struct FatturaPrincipale: Codable {
    public var numeroFatturaPrincipale: String
    public var dataFatturaPrincipale: Date
    
    public init(numeroFatturaPrincipale: String, dataFatturaPrincipale: Date) {
        self.numeroFatturaPrincipale = numeroFatturaPrincipale
        self.dataFatturaPrincipale = dataFatturaPrincipale
    }

    enum CodingKeys: String, CodingKey{
        case numeroFatturaPrincipale = "numerofatturaprincipale"
        case dataFatturaPrincipale = "datafatturaprincipale"
    }

    enum EncodableKeys: String, CodingKey {
        case numeroFatturaPrincipale = "NumeroFatturaPrincipale"
        case dataFatturaPrincipale = "DataFatturaPrincipale"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.numeroFatturaPrincipale, forKey: .numeroFatturaPrincipale)
        try container.encodeIfPresent(self.dataFatturaPrincipale, forKey: .dataFatturaPrincipale)
    }
}

// MARK: - 2.2 <DatiBeniServizi>
public struct DatiBeniServizi: Codable {
    public var dettaglioLinee: [DettaglioLinee]
    public var datiRiepilogo: [DatiRiepilogo]
    
    public init(dettaglioLinee: [DettaglioLinee], datiRiepilogo: [DatiRiepilogo]) {
        self.dettaglioLinee = dettaglioLinee
        self.datiRiepilogo = datiRiepilogo
    }

    enum CodingKeys: String, CodingKey{
        case dettaglioLinee = "dettagliolinee"
        case datiRiepilogo = "datiriepilogo"
    }

    enum EncodableKeys: String, CodingKey {
        case dettaglioLinee = "DettaglioLinee"
        case datiRiepilogo = "DatiRiepilogo"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.dettaglioLinee, forKey: .dettaglioLinee)
        try container.encodeIfPresent(self.datiRiepilogo, forKey: .datiRiepilogo)
    }
}

public struct DettaglioLinee: Codable {
    public var codiceArticolo: [CodiceArticolo]?
    public var numeroLinea: Int
    public var tipoCessionePrestazione: TipoCessionePrestazione?
    public var descrizione: String
    public var quantita: Double?
    public var unitaMisura: String?
    public var dataInizioPeriodo: Date?
    public var dataFinePeriodo: Date?
    public var prezzoUnitario: Double
    public var scontoMaggiorazione: [ScontoMaggiorazione]?
    public var prezzoTotale: Double
    public var aliquotaIva: Double
    @PABool public var ritenuta: Bool?
    public var natura: Natura?
    public var riferimentoAmministrazione: String?
    public var altriDatiGestionali: [AltriDatiGestionali]?
    
    public init(codiceArticolo: [CodiceArticolo]?, numeroLinea: Int, tipoCessionePrestazione: TipoCessionePrestazione?, descrizione: String, quantita: Double?, unitaMisura: String?, dataInizioPeriodo: Date?, dataFinePeriodo: Date?, prezzoUnitario: Double, scontoMaggiorazione: [ScontoMaggiorazione]?, prezzoTotale: Double, aliquotaIva: Double, ritenuta: Bool?, natura: Natura?, riferimentoAmministrazione: String?, altriDatiGestionali: [AltriDatiGestionali]?) {
        self.codiceArticolo = codiceArticolo
        self.numeroLinea = numeroLinea
        self.tipoCessionePrestazione = tipoCessionePrestazione
        self.descrizione = descrizione
        self.quantita = quantita
        self.unitaMisura = unitaMisura
        self.dataInizioPeriodo = dataInizioPeriodo
        self.dataFinePeriodo = dataFinePeriodo
        self.prezzoUnitario = prezzoUnitario
        self.scontoMaggiorazione = scontoMaggiorazione
        self.prezzoTotale = prezzoTotale
        self.aliquotaIva = aliquotaIva
        self.ritenuta = ritenuta
        self.natura = natura
        self.riferimentoAmministrazione = riferimentoAmministrazione
        self.altriDatiGestionali = altriDatiGestionali
    }

    
    enum CodingKeys: String, CodingKey{
        case codiceArticolo = "codicearticolo"
        case altriDatiGestionali = "altridatigestionali"
        case numeroLinea = "numerolinea"
        case tipoCessionePrestazione = "tipocessioneprestazione"
        case descrizione = "descrizione"
        case quantita = "quantita"
        case unitaMisura = "unitamisura"
        case dataInizioPeriodo = "datainizioperiodo"
        case dataFinePeriodo = "datafineperiodo"
        case prezzoUnitario = "prezzounitario"
        case scontoMaggiorazione = "scontomaggiorazione"
        case prezzoTotale = "prezzototale"
        case aliquotaIva = "aliquotaiva"
        case ritenuta = "ritenuta"
        case natura = "natura"
        case riferimentoAmministrazione = "riferimentoamministrazione"
    }

    enum EncodableKeys: String, CodingKey {
        case codiceArticolo = "CodiceArticolo"
        case altriDatiGestionali = "AltriDatiGestionali"
        case numeroLinea = "NumeroLinea"
        case tipoCessionePrestazione = "TipoCessionePrestazione"
        case descrizione = "Descrizione"
        case quantita = "Quantita"
        case unitaMisura = "UnitaMisura"
        case dataInizioPeriodo = "DataInizioPeriodo"
        case dataFinePeriodo = "DataFinePeriodo"
        case prezzoUnitario = "PrezzoUnitario"
        case scontoMaggiorazione = "ScontoMaggiorazione"
        case prezzoTotale = "PrezzoTotale"
        case aliquotaIva = "AliquotaIva"
        case ritenuta = "Ritenuta"
        case natura = "Natura"
        case riferimentoAmministrazione = "RiferimentoAmministrazione"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.codiceArticolo, forKey: .codiceArticolo)
        try container.encodeIfPresent(self.altriDatiGestionali, forKey: .altriDatiGestionali)
        try container.encode(self.numeroLinea, forKey: .numeroLinea)
        try container.encodeIfPresent(self.tipoCessionePrestazione, forKey: .tipoCessionePrestazione)
        try container.encode(self.descrizione, forKey: .descrizione)
        try container.encodeIfPresent(self.quantita, forKey: .quantita)
        try container.encodeIfPresent(self.unitaMisura, forKey: .unitaMisura)
        try container.encodeIfPresent(self.dataInizioPeriodo, forKey: .dataInizioPeriodo)
        try container.encodeIfPresent(self.dataFinePeriodo, forKey: .dataFinePeriodo)
        try container.encode(self.prezzoUnitario, forKey: .prezzoUnitario)
        try container.encodeIfPresent(self.scontoMaggiorazione, forKey: .scontoMaggiorazione)
        try container.encode(self.prezzoTotale, forKey: .prezzoTotale)
        try container.encode(self.aliquotaIva, forKey: .aliquotaIva)
        try container.encodeIfPresent(self.ritenuta, forKey: .ritenuta)
        try container.encodeIfPresent(self.natura, forKey: .natura)
        try container.encodeIfPresent(self.riferimentoAmministrazione, forKey: .riferimentoAmministrazione)
    }
}

public struct DatiRiepilogo: Codable {
    public var aliquotaIva: Double
    public var natura: Natura?
    public var speseAccessorie: Double?
    public var arrotondamento: Double?
    public var imponibileImporto: Double
    public var imposta: Double
    public var esigibilitaIva: EsigibilitaIVA?
    public var riferimentoNormativo: String?
    
    public init(aliquotaIva: Double, natura: Natura?, speseAccessorie: Double?, arrotondamento: Double?, imponibileImporto: Double, imposta: Double, esigibilitaIva: EsigibilitaIVA?, riferimentoNormativo: String?) {
        self.aliquotaIva = aliquotaIva
        self.natura = natura
        self.speseAccessorie = speseAccessorie
        self.arrotondamento = arrotondamento
        self.imponibileImporto = imponibileImporto
        self.imposta = imposta
        self.esigibilitaIva = esigibilitaIva
        self.riferimentoNormativo = riferimentoNormativo
    }

    enum CodingKeys: String, CodingKey{
        case aliquotaIva = "aliquotaiva"
        case natura = "natura"
        case speseAccessorie = "speseaccessorie"
        case arrotondamento = "arrotondamento"
        case imponibileImporto = "imponibileimporto"
        case imposta = "imposta"
        case esigibilitaIva = "esigibilitaiva"
        case riferimentoNormativo = "riferimentonormativo"
    }

    enum EncodableKeys: String, CodingKey {
        case aliquotaIva = "AliquotaIva"
        case natura = "Natura"
        case speseAccessorie = "SpeseAccessorie"
        case arrotondamento = "Arrotondamento"
        case imponibileImporto = "ImponibileImporto"
        case imposta = "Imposta"
        case esigibilitaIva = "EsigibilitaIVA"
        case riferimentoNormativo = "RiferimentoNormativo"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.aliquotaIva, forKey: .aliquotaIva)
        try container.encodeIfPresent(self.natura, forKey: .natura)
        try container.encodeIfPresent(self.speseAccessorie, forKey: .speseAccessorie)
        try container.encodeIfPresent(self.arrotondamento, forKey: .arrotondamento)
        try container.encode(self.imponibileImporto, forKey: .imponibileImporto)
        try container.encode(self.imposta, forKey: .imposta)
        try container.encodeIfPresent(self.esigibilitaIva, forKey: .esigibilitaIva)
        try container.encodeIfPresent(self.riferimentoNormativo, forKey: .riferimentoNormativo)
    }
}

public enum EsigibilitaIVA: String, Codable {
    case ESIGIBILITADIFFERITA = "D"
    case ESIGIBILITAIMMEDIATA = "I"
    case SCISSIONEDEIPAGAMENTI = "S"
}

public enum TipoCessionePrestazione: String, Codable {
    case SCONTO = "SC"
    case PREMIO = "PR"
    case ABBUONO = "AB"
    case SPESACCESSORIA = "AC"
}

public struct CodiceArticolo: Codable {
    public var codiceTipo: String
    public var codiceValore: String
    
    public init(codiceTipo: String, codiceValore: String) {
        self.codiceTipo = codiceTipo
        self.codiceValore = codiceValore
    }

    enum CodingKeys: String, CodingKey{
        case codiceTipo = "codicetipo"
        case codiceValore = "codicevalore"
    }

    enum EncodableKeys: String, CodingKey {
        case codiceTipo = "CodiceTipo"
        case codiceValore = "CodiceValore"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.codiceTipo, forKey: .codiceTipo)
        try container.encode(self.codiceValore, forKey: .codiceValore)
    }
}

public struct AltriDatiGestionali: Codable {
    public var tipoDato: String
    public var riferimentoTesto: String?
    public var riferimentoNumero: Double?
    public var riferimentoData: Date?
    
    public init(tipoDato: String, riferimentoTesto: String?, riferimentoNumero: Double?, riferimentoData: Date?) {
        self.tipoDato = tipoDato
        self.riferimentoTesto = riferimentoTesto
        self.riferimentoNumero = riferimentoNumero
        self.riferimentoData = riferimentoData
    }

    enum CodingKeys: String, CodingKey{
        case tipoDato = "tipodato"
        case riferimentoTesto = "riferimentotesto"
        case riferimentoNumero = "riferimentonumero"
        case riferimentoData = "riferimentodata"
    }

    enum EncodableKeys: String, CodingKey {
        case tipoDato = "TipoDato"
        case riferimentoTesto = "RiferimentoTesto"
        case riferimentoNumero = "RiferimentoNumero"
        case riferimentoData = "RiferimentoData"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.tipoDato, forKey: .tipoDato)
        try container.encodeIfPresent(self.riferimentoTesto, forKey: .riferimentoTesto)
        try container.encodeIfPresent(self.riferimentoNumero, forKey: .riferimentoNumero)
        try container.encodeIfPresent(self.riferimentoData, forKey: .riferimentoData)
    }
}

// MARK: - 2.3 <DatiVeicoli>
public struct DatiVeicoli: Codable {
    public var data: Date
    public var totalePercorso: String

    public init(data: Date, totalePercorso: String) {
        self.data = data
        self.totalePercorso = totalePercorso
    }

    enum CodingKeys: String, CodingKey{
        case data = "data"
        case totalePercorso = "totalepercorso"
    }

    enum EncodableKeys: String, CodingKey {
        case data = "Data"
        case totalePercorso = "TotalePercorso"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.data, forKey: .data)
        try container.encode(self.totalePercorso, forKey: .totalePercorso)
    }
}

// MARK: - 2.4 <DatiPagamento>
public struct DatiPagamento: Codable {
    public var dettaglioPagamento: [DettaglioPagamento]
    public var condizioniPagamento: CondizioniPagamento
    
    public init(dettaglioPagamento: [DettaglioPagamento], condizioniPagamento: CondizioniPagamento) {
        self.dettaglioPagamento = dettaglioPagamento
        self.condizioniPagamento = condizioniPagamento
    }

    
    enum CodingKeys: String, CodingKey{
        case dettaglioPagamento = "dettagliopagamento"
        case condizioniPagamento = "condizionipagamento"
    }

    enum EncodableKeys: String, CodingKey {
        case dettaglioPagamento = "DettaglioPagamento"
        case condizioniPagamento = "CondizioniPagamento"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.dettaglioPagamento, forKey: .dettaglioPagamento)
        try container.encode(self.condizioniPagamento, forKey: .condizioniPagamento)
    }
}

public struct DettaglioPagamento: Codable {
    public var beneficiario: String?
    public var modalitaPagamento: ModalitaPagamento
    public var dataRiferimentoTerminiPagamento: Date?
    public var giorniTerminiPagamento: Int?
    public var dataScadenzaPagamento: Date?
    public var importoPagamento: Double
    public var codUfficioPostale: String?
    public var cognomeQuietanzante: String?
    public var nomeQuietanzante: String?
    public var cfQuietanzante: String?
    public var titoloQuietanzante: String?
    public var istitutoFinanziario: String?
    public var iban: String?
    public var abi: Int?
    public var cab: Int?
    public var bic: String?
    public var scontoPagamentoAnticipato: Double?
    public var dataLimitePagamentoAnticipato: Date?
    public var penalitaPagamentiRitardati: Double?
    public var dataDecorrenzaPenale: Date?
    public var codicePagamento: String?
    
    public init(beneficiario: String?, modalitaPagamento: ModalitaPagamento, dataRiferimentoTerminiPagamento: Date?, giorniTerminiPagamento: Int?, dataScadenzaPagamento: Date?, importoPagamento: Double, codUfficioPostale: String?, cognomeQuietanzante: String?, nomeQuietanzante: String?, cfQuietanzante: String?, titoloQuietanzante: String?, istitutoFinanziario: String?, iban: String?, abi: Int?, cab: Int?, bic: String?, scontoPagamentoAnticipato: Double?, dataLimitePagamentoAnticipato: Date?, penalitaPagamentiRitardati: Double?, dataDecorrenzaPenale: Date?, codicePagamento: String?) {
        self.beneficiario = beneficiario
        self.modalitaPagamento = modalitaPagamento
        self.dataRiferimentoTerminiPagamento = dataRiferimentoTerminiPagamento
        self.giorniTerminiPagamento = giorniTerminiPagamento
        self.dataScadenzaPagamento = dataScadenzaPagamento
        self.importoPagamento = importoPagamento
        self.codUfficioPostale = codUfficioPostale
        self.cognomeQuietanzante = cognomeQuietanzante
        self.nomeQuietanzante = nomeQuietanzante
        self.cfQuietanzante = cfQuietanzante
        self.titoloQuietanzante = titoloQuietanzante
        self.istitutoFinanziario = istitutoFinanziario
        self.iban = iban
        self.abi = abi
        self.cab = cab
        self.bic = bic
        self.scontoPagamentoAnticipato = scontoPagamentoAnticipato
        self.dataLimitePagamentoAnticipato = dataLimitePagamentoAnticipato
        self.penalitaPagamentiRitardati = penalitaPagamentiRitardati
        self.dataDecorrenzaPenale = dataDecorrenzaPenale
        self.codicePagamento = codicePagamento
    }

    enum CodingKeys: String, CodingKey{
        case beneficiario = "beneficiario"
        case modalitaPagamento = "modalitapagamento"
        case dataRiferimentoTerminiPagamento = "datariferimentoterminipagamento"
        case giorniTerminiPagamento = "giorniterminipagamento"
        case dataScadenzaPagamento = "datascadenzapagamento"
        case importoPagamento = "importopagamento"
        case codUfficioPostale = "codufficiopostale"
        case cognomeQuietanzante = "cognomequietanzante"
        case nomeQuietanzante = "nomequietanzante"
        case cfQuietanzante = "cfquietanzante"
        case titoloQuietanzante = "titoloquietanzante"
        case istitutoFinanziario = "istitutofinanziario"
        case iban = "iban"
        case abi = "abi"
        case cab = "cab"
        case bic = "bic"
        case scontoPagamentoAnticipato = "scontopagamentoanticipato"
        case dataLimitePagamentoAnticipato = "datalimitepagamentoanticipato"
        case penalitaPagamentiRitardati = "penalitapagamentiritardati"
        case dataDecorrenzaPenale = "datadecorrenzapenale"
        case codicePagamento = "codicepagamento"
    }

    enum EncodableKeys: String, CodingKey {
        case beneficiario = "Beneficiario"
        case modalitaPagamento = "ModalitaPagamento"
        case dataRiferimentoTerminiPagamento = "DataRiferimentoTerminiPagamento"
        case giorniTerminiPagamento = "GiorniTerminiPagamento"
        case dataScadenzaPagamento = "DataScadenzaPagamento"
        case importoPagamento = "ImportoPagamento"
        case codUfficioPostale = "CodUfficioPostale"
        case cognomeQuietanzante = "CognomeQuietanzante"
        case nomeQuietanzante = "NomeQuietanzante"
        case cfQuietanzante = "CfQuietanzante"
        case titoloQuietanzante = "TitoloQuietanzante"
        case istitutoFinanziario = "IstitutoFinanziario"
        case iban = "Iban"
        case abi = "Abi"
        case cab = "Cab"
        case bic = "Bic"
        case scontoPagamentoAnticipato = "ScontoPagamentoAnticipato"
        case dataLimitePagamentoAnticipato = "DataLimitePagamentoAnticipato"
        case penalitaPagamentiRitardati = "PenalitaPagamentiRitardati"
        case dataDecorrenzaPenale = "DataDecorrenzaPenale"
        case codicePagamento = "CodicePagamento"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encodeIfPresent(self.beneficiario, forKey: .beneficiario)
        try container.encode(self.modalitaPagamento, forKey: .modalitaPagamento)
        try container.encodeIfPresent(self.dataRiferimentoTerminiPagamento, forKey: .dataRiferimentoTerminiPagamento)
        try container.encodeIfPresent(self.giorniTerminiPagamento, forKey: .giorniTerminiPagamento)
        try container.encodeIfPresent(self.dataScadenzaPagamento, forKey: .dataScadenzaPagamento)
        try container.encodeIfPresent(self.importoPagamento, forKey: .importoPagamento)
        try container.encodeIfPresent(self.codUfficioPostale, forKey: .codUfficioPostale)
        try container.encodeIfPresent(self.cognomeQuietanzante, forKey: .cognomeQuietanzante)
        try container.encodeIfPresent(self.nomeQuietanzante, forKey: .nomeQuietanzante)
        try container.encodeIfPresent(self.cfQuietanzante, forKey: .cfQuietanzante)
        try container.encodeIfPresent(self.titoloQuietanzante, forKey: .titoloQuietanzante)
        try container.encodeIfPresent(self.istitutoFinanziario, forKey: .istitutoFinanziario)
        try container.encodeIfPresent(self.iban, forKey: .iban)
        try container.encodeIfPresent(self.abi, forKey: .abi)
        try container.encodeIfPresent(self.cab, forKey: .cab)
        try container.encodeIfPresent(self.bic, forKey: .bic)
        try container.encodeIfPresent(self.scontoPagamentoAnticipato, forKey: .scontoPagamentoAnticipato)
        try container.encodeIfPresent(self.dataLimitePagamentoAnticipato, forKey: .dataLimitePagamentoAnticipato)
        try container.encodeIfPresent(self.penalitaPagamentiRitardati, forKey: .penalitaPagamentiRitardati)
        try container.encodeIfPresent(self.dataDecorrenzaPenale, forKey: .dataDecorrenzaPenale)
        try container.encodeIfPresent(self.codicePagamento, forKey: .codicePagamento)
    }
}

public enum ModalitaPagamento: String, Codable {
    case CONTANTI = "MP01"
    case ASSEGNO = "MP02"
    case ASSEGNO_CIRCOLARE = "MP03"
    case CONTANTI_PRESSO_TESORERIA = "MP04"
    case BONIFICO = "MP05"
    case VAGLIA_CAMBIARIO = "MP06"
    case BOLLETTINO_BANCARIO = "MP07"
    case CARTA_DI_PAGAMENTO = "MP08"
    case RID = "MP09"
    case RID_UTENZE = "MP10"
    case RID_VELOCE = "MP11"
    case RIBA = "MP12"
    case MAV = "MP13"
    case QUIETANZA_ERARIO = "MP14"
    case GIROCONTO_SU_CONTI_DI_CONTABILITA_SPECIALE = "MP15"
    case DOMICIALIAZIONE_BANCARIA = "MP16"
    case DOMICIALIAZIONE_POSTALE = "MP17"
    case BOLLETTINO_DI_CC_POSTALE = "MP18"
    case SEPA_DIRECT_DEBIT = "MP19"
    case SEPA_DIRECT_DEBIT_CORE = "MP20"
    case SEPA_DIRECT_DEBIT_B2B = "MP21"
    case TRATTENUTA_SU_SOMME_GIA_RISCOSSE = "MP22"
    case PAGO_PA = "MP23"
}

public enum CondizioniPagamento: String, Codable {
    case PAGAMENTOARATE = "TP01"
    case PAGAMENTOCOMPLETO = "TP02"
    case ANTICIPO = "TP03"
}

// MARK: - 2.5 <Allegati>
public struct Allegati: Codable {
    public var nomeAttachment: String
    public var algoritmoCompressione: String?
    public var formatoAttachment: String?
    public var descrizioneAttachment: String?
    public var attachment: String
    
    public init(nomeAttachment: String, algoritmoCompressione: String?, formatoAttachment: String?, descrizioneAttachment: String?, attachment: String) {
        self.nomeAttachment = nomeAttachment
        self.algoritmoCompressione = algoritmoCompressione
        self.formatoAttachment = formatoAttachment
        self.descrizioneAttachment = descrizioneAttachment
        self.attachment = attachment
    }

    enum CodingKeys: String, CodingKey{
        case nomeAttachment = "nomeattachment"
        case algoritmoCompressione = "algoritmocompressione"
        case formatoAttachment = "formatoattachment"
        case descrizioneAttachment = "descrizioneattachment"
        case attachment = "attachment"
    }

    enum EncodableKeys: String, CodingKey{
        case nomeAttachment = "NomeAttachment"
        case algoritmoCompressione = "AlgoritmoCompressione"
        case formatoAttachment = "FormatoAttachment"
        case descrizioneAttachment = "DescrizioneAttachment"
        case attachment = "Attachment"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodableKeys.self)
        try container.encode(self.nomeAttachment, forKey: .nomeAttachment)
        try container.encodeIfPresent(self.algoritmoCompressione, forKey: .algoritmoCompressione)
        try container.encodeIfPresent(self.formatoAttachment, forKey: .formatoAttachment)
        try container.encodeIfPresent(self.descrizioneAttachment, forKey: .descrizioneAttachment)
        try container.encode(self.attachment, forKey: .attachment)
    }
}
