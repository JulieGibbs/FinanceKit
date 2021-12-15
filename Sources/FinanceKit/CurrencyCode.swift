//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

/// Contains all available currencies which a monetary value could be of.
/// Currencies are uniquely identified by their currency code after the ISO 4217 standard.
/// A currency code is a three-letter code that is usually composed of
/// a country’s two-character Internet country code and the currency unit.
/// For example, the currency code for the Australian dollar is “AUD”.
public enum CurrencyCode: String, Codable, CaseIterable {
    case none = ""
    case afghani = "AFN"
    case algerianDinar = "DZD"
    case argentinePeso = "ARS"
    case armenianDram = "AMD"
    case arubanFlorin = "AWG"
    case australianDollar = "AUD"
    case azerbaijanManat = "AZN"
    case bahamianDollar = "BSD"
    case bahrainiDinar = "BHD"
    case baht = "THB"
    case balboa = "PAB"
    case barbadosDollar = "BBD"
    case belarusianRuble = "BYN"
    case belizeDollar = "BZD"
    case bermudianDollar = "BMD"
    case boliviano = "BOB"
    case bolívar = "VEF"
    case brazilianReal = "BRL"
    case bruneiDollar = "BND"
    case bulgarianLev = "BGN"
    case burundiFranc = "BIF"
    case caboVerdeEscudo = "CVE"
    case canadianDollar = "CAD"
    case caymanIslandsDollar = "KYD"
    case chileanPeso = "CLP"
    case colombianPeso = "COP"
    case comorianFranc = "KMF"
    case congoleseFranc = "CDF"
    case convertibleMark = "BAM"
    case cordobaOro = "NIO"
    case costaRicanColon = "CRC"
    case cubanPeso = "CUP"
    case czechKoruna = "CZK"
    case dalasi = "GMD"
    case danishKrone = "DKK"
    case denar = "MKD"
    case djiboutiFranc = "DJF"
    case dobra = "STN"
    case dominicanPeso = "DOP"
    case dong = "VND"
    case eastCaribbeanDollar = "XCD"
    case egyptianPound = "EGP"
    case elSalvadorColon = "SVC"
    case ethiopianBirr = "ETB"
    case euro = "EUR"
    case falklandIslandsPound = "FKP"
    case fijiDollar = "FJD"
    case forint = "HUF"
    case ghanaCedi = "GHS"
    case gibraltarPound = "GIP"
    case gourde = "HTG"
    case guarani = "PYG"
    case guineanFranc = "GNF"
    case guyanaDollar = "GYD"
    case hongKongDollar = "HKD"
    case hryvnia = "UAH"
    case icelandKrona = "ISK"
    case indianRupee = "INR"
    case iranianRial = "IRR"
    case iraqiDinar = "IQD"
    case jamaicanDollar = "JMD"
    case jordanianDinar = "JOD"
    case kenyanShilling = "KES"
    case kina = "PGK"
    case kuna = "HRK"
    case kuwaitiDinar = "KWD"
    case kwanza = "AOA"
    case kyat = "MMK"
    case laoKip = "LAK"
    case lari = "GEL"
    case lebanesePound = "LBP"
    case lek = "ALL"
    case lempira = "HNL"
    case leone = "SLL"
    case liberianDollar = "LRD"
    case libyanDinar = "LYD"
    case lilangeni = "SZL"
    case loti = "LSL"
    case malagasyAriary = "MGA"
    case malawiKwacha = "MWK"
    case malaysianRinggit = "MYR"
    case mauritiusRupee = "MUR"
    case mexicanPeso = "MXN"
    case mexicanUnidadDeInversion = "MXV"
    case moldovanLeu = "MDL"
    case moroccanDirham = "MAD"
    case mozambiqueMetical = "MZN"
    case mvdol = "BOV"
    case naira = "NGN"
    case nakfa = "ERN"
    case namibiaDollar = "NAD"
    case nepaleseRupee = "NPR"
    case netherlandsAntilleanGuilder = "ANG"
    case newIsraeliSheqel = "ILS"
    case newTaiwanDollar = "TWD"
    case newZealandDollar = "NZD"
    case ngultrum = "BTN"
    case northKoreanWon = "KPW"
    case norwegianKrone = "NOK"
    case ouguiya = "MRU"
    case paanga = "TOP"
    case pakistanRupee = "PKR"
    case pataca = "MOP"
    case pesoConvertible = "CUC"
    case pesoUruguayo = "UYU"
    case philippinePiso = "PHP"
    case poundSterling = "GBP"
    case pula = "BWP"
    case qatariRial = "QAR"
    case quetzal = "GTQ"
    case rand = "ZAR"
    case rialOmani = "OMR"
    case riel = "KHR"
    case romanianLeu = "RON"
    case rufiyaa = "MVR"
    case rupiah = "IDR"
    case russianRuble = "RUB"
    case rwandaFranc = "RWF"
    case saintHelenaPound = "SHP"
    case saudiRiyal = "SAR"
    case serbianDinar = "RSD"
    case seychellesRupee = "SCR"
    case singaporeDollar = "SGD"
    case sol = "PEN"
    case solomonIslandsDollar = "SBD"
    case som = "KGS"
    case somaliShilling = "SOS"
    case somoni = "TJS"
    case southSudanesePound = "SSP"
    case sriLankaRupee = "LKR"
    case sudanesePound = "SDG"
    case surinamDollar = "SRD"
    case swedishKrona = "SEK"
    case swissFranc = "CHF"
    case syrianPound = "SYP"
    case taka = "BDT"
    case tala = "WST"
    case tanzanianShilling = "TZS"
    case tenge = "KZT"
    case trinidadAndTobagoDollar = "TTD"
    case tugrik = "MNT"
    case tunisianDinar = "TND"
    case turkishLira = "TRY"
    case turkmenistanNewManat = "TMT"
    case uaeDirham = "AED"
    case ugandaShilling = "UGX"
    case unidadDeFomento = "CLF"
    case unidadDeValorReal = "COU"
    case unitedStatesDollar = "USD"
    case uruguayPesoEnUnidadesIndexadas = "UYI"
    case uzbekistanSum = "UZS"
    case vatu = "VUV"
    case wirEuro = "CHE"
    case wirFranc = "CHW"
    case won = "KRW"
    case yemeniRial = "YER"
    case yen = "JPY"
    case yuanRenminbi = "CNY"
    case zambianKwacha = "ZMW"
    case zimbabweDollar = "ZWL"
    case zloty = "PLN"
}
