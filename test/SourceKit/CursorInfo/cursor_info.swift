import Foo
import FooSwiftModule

var glob : Int

func foo(x: Int) {}

func goo(x: Int) {
  foo(glob+x+Int(fooIntVar)+fooSwiftFunc())
}

/// Aaa.  S1.  Bbb.
struct S1 {}
var w : S1
func test2(x: S1) {}

class CC {
  init(x: Int) {
    self.init(x:0)
  }
}

var testString = "testString"
let testLetString = "testString"

func testLetParam(arg1 : Int) {
}
func testVarParam(var arg1 : Int) {
}

func testDefaultParam(arg1: Int = 0) {
}

fooSubFunc1(0)

func myFunc(arg1: String) {
}
func myFunc(arg1: String, options: Int) {
}

var derivedObj = FooClassDerived()

typealias MyInt = Int
var x: MyInt

import FooHelper.FooHelperSub

class C2 {
  lazy var lazy_bar : Int = {
    return x
  }()
}

func test1(foo: FooUnavailableMembers) {
  foo.availabilityIntroduced()
  foo.swiftUnavailable()
  foo.unavailable()
  foo.availabilityIntroducedMsg()
  foo.availabilityDeprecated()
}

public class SubscriptCursorTest {
  public subscript(i: Int) -> Int {
    return 0
  }

  public static func test() {
    let s = SubscriptCursorTest()
    let a = s[1234] + s[4321]
  }
}

class C3 {
  deinit {}
  init!(x: Int) { return nil }
  init?(y: Int) { return nil }
  init(z: Int) throws {}
}

struct S2<T, U where T == U> {
  func foo<V, W where V == W> (closure: ()->()) -> ()->() { return closure }
}
class C4<T, U where T == U> {}
enum E1<T, U where T == U> {}

func nonDefaultArgNames(external1 local1: Int, _ local2: Int, external3 local3: Int, external4 _: Int, _: Int) {}

func nestedFunctionType(closure: (y: (z: Int) -> Int) -> Int) -> (y: (z: Int) -> Int) -> Int) { return closure }

enum E2 {
  case C1
  case C2(x: Int, y: String), C3(Int)
}

enum E3: String {
  case C = "a"
}

func refEnumElements() {
  let w = E2.C1
  let x = E2.C2(x: 1, y: "")
  let y: E2 = .C2(x: 2, y: "")
  let z: E3 = .C
}

class C4 {
  static var v1: Int = 0
  final class var v2: Int = 0
  static func f1() {}
  final class func f2() {}
}

protocol P1 {
  associatedtype T
}

func genReq<U, V: P1 where V.T == U>(u: U, v: V) {}

@objc class C5 {
  @objc(mmm1)
  @noreturn
  func m1() {}

  private(set)
  public
  var v1: Int = 1
}

let tupleVar1: (((Int, Int), y: Int), z: Int)
let tupleVar2: (f: ()->(), g: (x: Int)->Int)
let tupleVar3: (f: (inout x: (Int, Int)) throws ->(), Int)

enum E4: Int {
  case A = -1
  case B = 0
  case C = 1
}
enum E5: Int {
  case A  // implicit = 0
}
enum E6: Float {
  case A = -0.0
  case B = 1e10
}

class C6: C4, P1 {
  typealias T = Int
}

protocol P2: class, P1 {}

typealias MyAlias<T, U> = (T, U, T, U)
typealias MyAlias2<A, B> = MyAlias<A, B>

func paramAutoclosureNoescape1(@noescape msg: ()->String) {}
func paramAutoclosureNoescape2(@autoclosure msg: ()->String) {}
func paramAutoclosureNoescape3(@autoclosure(escaping) msg: ()->String) {}

func paramDefaultPlaceholder(f: StaticString = #function, file: StaticString = #file, line: UInt = #line, col: UInt = #column, arr: [Int] = [], dict: [Int:Int] = [:], opt: Int? = nil, reg: Int = 1) {}

protocol P3 {
  func f(s: Self) -> Self
}
extension P3: P2 {
  func f(s: Self) -> Self { return s }
}

class C7 {
  func f() -> Self { return self }
}

public class FooClass1 {
  @warn_unused_result
  public func fooFunc1() {}
}

func goo1(f : FooClass1) {
  f.fooFunc1()
}

public protocol P4 {
  /// foo1 comment from P4
  func foo1()
  /// foo2 comment from P4
  func foo2()
}

public class C8 : P4 {
  public func foo1() {
  }
  /// foo2 comment from C1
  public func foo2() {
  }
}

func foo2(f: C8) {
  f.foo1()
  f.foo2()
}

// RUN: rm -rf %t.tmp
// RUN: mkdir %t.tmp
// RUN: %swiftc_driver -emit-module -o %t.tmp/FooSwiftModule.swiftmodule %S/Inputs/FooSwiftModule.swift
// RUN: %sourcekitd-test -req=cursor -pos=9:8 %s -- -F %S/../Inputs/libIDE-mock-sdk %mcp_opt %s | FileCheck -check-prefix=CHECK1 %s
// CHECK1:      source.lang.swift.ref.var.global (4:5-4:9)
// CHECK1-NEXT: glob
// CHECK1-NEXT: s:v11cursor_info4globSi{{$}}
// CHECK1-NEXT: Int

// RUN: %sourcekitd-test -req=cursor -pos=9:11 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK2 %s
// CHECK2:      source.lang.swift.ref.function.operator.infix ()
// CHECK2-NEXT: +
// CHECK2-NEXT: s:ZFsoi1pFTSiSi_Si
// CHECK2-NEXT: (Int, Int) -> Int{{$}}
// CHECK2-NEXT: Swift{{$}}
// CHECK2-NEXT: <Group>Math/Integers</Group>
// CHECK2-NEXT: SYSTEM
// CHECK2-NEXT: <Declaration>func +(lhs: <Type usr="s:Si">Int</Type>, rhs: <Type usr="s:Si">Int</Type>) -&gt; <Type usr="s:Si">Int</Type></Declaration>
// CHECK2-NEXT: <decl.function.operator.infix><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>+</decl.name>(<decl.var.parameter><decl.var.parameter.name>lhs</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>, <decl.var.parameter><decl.var.parameter.name>rhs</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>) -&gt; <decl.function.returntype><ref.struct usr="s:Si">Int</ref.struct></decl.function.returntype></decl.function.operator.infix>

// RUN: %sourcekitd-test -req=cursor -pos=9:12 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK3 %s
// CHECK3:      source.lang.swift.ref.var.local (8:10-8:11)
// CHECK3-NEXT: x{{$}}
// CHECK3-NEXT: s:vF11cursor_info3gooFSiT_L_1xSi{{$}}
// CHECK3-NEXT: Int{{$}}
// CHECK3-NEXT: <Declaration>let x: <Type usr="s:Si">Int</Type></Declaration>
// CHECK3-NEXT: <decl.var.parameter><syntaxtype.keyword>let</syntaxtype.keyword> <decl.var.parameter.name>x</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>

// RUN: %sourcekitd-test -req=cursor -pos=9:18 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK4 %s
// CHECK4:      source.lang.swift.ref.var.global ({{.*}}Foo.framework/Headers/Foo.h:62:12-62:21)
// CHECK4-NEXT: fooIntVar{{$}}
// CHECK4-NEXT: c:@fooIntVar{{$}}
// CHECK4-NEXT: Int32{{$}}
// CHECK4-NEXT: Foo{{$}}
// CHECK4-NEXT: <Declaration>var fooIntVar: <Type usr="s:Vs5Int32">Int32</Type></Declaration>
// CHECK4-NEXT: <decl.var.global><syntaxtype.keyword>var</syntaxtype.keyword> <decl.name>fooIntVar</decl.name>: <decl.var.type><ref.struct usr="s:Vs5Int32">Int32</ref.struct></decl.var.type></decl.var.global>
// CHECK4-NEXT: <Variable file="{{[^"]+}}Foo.h" line="{{[0-9]+}}" column="{{[0-9]+}}"><Name>fooIntVar</Name><USR>c:@fooIntVar</USR><Declaration>var fooIntVar: Int32</Declaration><Abstract><Para> Aaa. fooIntVar. Bbb.</Para></Abstract></Variable>

// RUN: %sourcekitd-test -req=cursor -pos=8:7 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK5 %s
// CHECK5:      source.lang.swift.decl.function.free (8:6-8:17)
// CHECK5-NEXT: goo(_:){{$}}
// CHECK5-NEXT: s:F11cursor_info3gooFSiT_{{$}}
// CHECK5-NEXT: (Int) -> (){{$}}

// RUN: %sourcekitd-test -req=cursor -pos=9:32 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK6 %s
// CHECK6:      source.lang.swift.ref.function.free ()
// CHECK6-NEXT: fooSwiftFunc
// CHECK6-NEXT: s:F14FooSwiftModule12fooSwiftFuncFT_Si
// CHECK6-NEXT: () -> Int
// CHECK6-NEXT: FooSwiftModule
// CHECK6-NEXT: <Declaration>func fooSwiftFunc() -&gt; <Type usr="s:Si">Int</Type></Declaration>
// CHECK6-NEXT: <decl.function.free><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>fooSwiftFunc</decl.name>() -&gt; <decl.function.returntype><ref.struct usr="s:Si">Int</ref.struct></decl.function.returntype></decl.function.free>
// CHECK6-NEXT: {{^}}<Function><Name>fooSwiftFunc()</Name><USR>s:F14FooSwiftModule12fooSwiftFuncFT_Si</USR><Declaration>func fooSwiftFunc() -&gt; Int</Declaration><Abstract><Para>This is &apos;fooSwiftFunc&apos; from &apos;FooSwiftModule&apos;.</Para></Abstract></Function>{{$}}

// RUN: %sourcekitd-test -req=cursor -pos=14:10 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK7 %s
// CHECK7:      source.lang.swift.ref.struct (13:8-13:10)
// CHECK7-NEXT: S1
// CHECK7-NEXT: s:V11cursor_info2S1
// CHECK7-NEXT: S1.Type
// CHECK7-NEXT: <Declaration>struct S1</Declaration>
// CHECK7-NEXT: <decl.struct><syntaxtype.keyword>struct</syntaxtype.keyword> <decl.name>S1</decl.name></decl.struct>
// CHECK7-NEXT: <Class file="{{[^"]+}}cursor_info.swift" line="13" column="8"><Name>S1</Name><USR>s:V11cursor_info2S1</USR><Declaration>struct S1</Declaration><Abstract><Para>Aaa.  S1.  Bbb.</Para></Abstract></Class>

// RUN: %sourcekitd-test -req=cursor -pos=19:12 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK8 %s
// CHECK8:      source.lang.swift.ref.function.constructor (18:3-18:15)
// CHECK8-NEXT: init
// CHECK8-NEXT: s:FC11cursor_info2CCcFT1xSi_S0_
// CHECK8-NEXT: CC.Type -> (x: Int) -> CC
// CHECK8-NEXT: <Declaration>convenience init(x: <Type usr="s:Si">Int</Type>)</Declaration>
// CHECK8-NEXT: <decl.function.constructor><syntaxtype.keyword>convenience</syntaxtype.keyword> <syntaxtype.keyword>init</syntaxtype.keyword>(<decl.var.parameter><decl.var.parameter.argument_label>x</decl.var.parameter.argument_label>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>)</decl.function.constructor>

// RUN: %sourcekitd-test -req=cursor -pos=23:6 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK9 %s
// CHECK9:      source.lang.swift.decl.var.global (23:5-23:15)
// CHECK9: <Declaration>var testString: <Type usr="s:SS">String</Type></Declaration>
// CHECK9: <decl.var.global><syntaxtype.keyword>var</syntaxtype.keyword> <decl.name>testString</decl.name>: <decl.var.type><ref.struct usr="s:SS">String</ref.struct></decl.var.type></decl.var.global>

// RUN: %sourcekitd-test -req=cursor -pos=24:6 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK10 %s
// CHECK10: source.lang.swift.decl.var.global (24:5-24:18)
// CHECK10: <Declaration>let testLetString: <Type usr="s:SS">String</Type></Declaration>
// CHECK10: <decl.var.global><syntaxtype.keyword>let</syntaxtype.keyword> <decl.name>testLetString</decl.name>: <decl.var.type><ref.struct usr="s:SS">String</ref.struct></decl.var.type></decl.var.global>

// RUN: %sourcekitd-test -req=cursor -pos=26:20 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK11 %s
// CHECK11: source.lang.swift.decl.var.parameter (26:19-26:23)
// CHECK11: <Declaration>let arg1: <Type usr="s:Si">Int</Type></Declaration>
// CHECK11: <decl.var.parameter><syntaxtype.keyword>let</syntaxtype.keyword> <decl.var.parameter.name>arg1</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>

// RUN: %sourcekitd-test -req=cursor -pos=28:24 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK12 %s
// CHECK12: source.lang.swift.decl.var.parameter (28:23-28:27)
// CHECK12: <Declaration>var arg1: <Type usr="s:Si">Int</Type></Declaration>
// CHECK12: <decl.var.parameter><syntaxtype.keyword>var</syntaxtype.keyword> <decl.var.parameter.name>arg1</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>

// RUN: %sourcekitd-test -req=cursor -pos=31:7 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK13 %s
// CHECK13: source.lang.swift.decl.function.free (31:6-31:37)
// CHECK13: <Declaration>func testDefaultParam(arg1: <Type usr="s:Si">Int</Type> = default)</Declaration>
// CHECK13: <decl.function.free><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>testDefaultParam</decl.name>(<decl.var.parameter><decl.var.parameter.name>arg1</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type> = <syntaxtype.keyword>default</syntaxtype.keyword></decl.var.parameter>)</decl.function.free>

// RUN: %sourcekitd-test -req=cursor -pos=34:4 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK14 %s
// CHECK14: source.lang.swift.ref.function.free ({{.*}}Foo.framework/Frameworks/FooSub.framework/Headers/FooSub.h:4:5-4:16)
// CHECK14: fooSubFunc1
// CHECK14: c:@F@fooSubFunc1
// CHECK14: Foo.FooSub{{$}}

// RUN: %sourcekitd-test -req=cursor -pos=38:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK15 %s
// CHECK15: source.lang.swift.decl.function.free (38:6-38:40)
// CHECK15: myFunc
// CHECK15: <Declaration>func myFunc(arg1: <Type usr="s:SS">String</Type>, options: <Type usr="s:Si">Int</Type>)</Declaration>
// CHECK15: <decl.function.free><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>myFunc</decl.name>(<decl.var.parameter><decl.var.parameter.name>arg1</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:SS">String</ref.struct></decl.var.parameter.type></decl.var.parameter>, <decl.var.parameter><decl.var.parameter.argument_label>options</decl.var.parameter.argument_label>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>)</decl.function.free>
// CHECK15: RELATED BEGIN
// CHECK15-NEXT: <RelatedName usr="s:F11cursor_info6myFuncFSST_">myFunc(_:)</RelatedName>
// CHECK15-NEXT: RELATED END

// RUN: %sourcekitd-test -req=cursor -pos=41:26 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK16 %s
// CHECK16:      source.lang.swift.ref.class ({{.*}}Foo.framework/Headers/Foo.h:157:12-157:27)
// CHECK16-NEXT: FooClassDerived
// CHECK16-NEXT: c:objc(cs)FooClassDerived
// CHECK16: <Declaration>class FooClassDerived : <Type usr="c:objc(cs)FooClassBase">FooClassBase</Type>, <Type usr="c:objc(pl)FooProtocolDerived">FooProtocolDerived</Type></Declaration>
// CHECK16-NEXT: <decl.class><syntaxtype.keyword>class</syntaxtype.keyword> <decl.name>FooClassDerived</decl.name> : <ref.class usr="c:objc(cs)FooClassBase">FooClassBase</ref.class>, <ref.protocol usr="c:objc(pl)FooProtocolDerived">FooProtocolDerived</ref.protocol></decl.class>

// RUN: %sourcekitd-test -req=cursor -pos=1:10 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK17 %s
// CHECK17:      source.lang.swift.ref.module ()
// CHECK17-NEXT: Foo{{$}}

// RUN: %sourcekitd-test -req=cursor -pos=44:10 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK18 %s
// CHECK18: source.lang.swift.ref.typealias (43:11-43:16)
// CHECK18: <Declaration>typealias MyInt = <Type usr="s:Si">Int</Type></Declaration>
// CHECK18: <decl.typealias><syntaxtype.keyword>typealias</syntaxtype.keyword> <decl.name>MyInt</decl.name> = <ref.struct usr="s:Si">Int</ref.struct></decl.typealias>

// RUN: %sourcekitd-test -req=cursor -pos=46:10 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK19 %s
// CHECK19:      source.lang.swift.ref.module ()
// CHECK19-NEXT: FooHelper{{$}}

// RUN: %sourcekitd-test -req=cursor -pos=46:25 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK20 %s
// CHECK20:      source.lang.swift.ref.module ()
// CHECK20-NEXT: FooHelperSub{{$}}

// RUN: %sourcekitd-test -req=cursor -pos=50:12 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK21 %s
// CHECK21:      source.lang.swift.ref.var.global (44:5-44:6)
// CHECK21-NEXT:  {{^}}x{{$}}

// RUN: %sourcekitd-test -req=cursor -pos=55:15 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK22 %s
// CHECK22: <Declaration>func availabilityIntroduced()</Declaration>
// CHECK22: <decl.function.method.instance><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>availabilityIntroduced</decl.name>()</decl.function.method.instance>

// RUN: %sourcekitd-test -req=cursor -pos=56:15 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK23 %s
// CHECK23-NOT: <Declaration>func swiftUnavailable()</Declaration>
// CHECK23-NOT: <decl.function.method.instance><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>swiftUnavailable</decl.name>()</decl.function.method.instance>

// RUN: %sourcekitd-test -req=cursor -pos=57:15 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK24 %s
// CHECK24-NOT: <Declaration>func unavailable()</Declaration>
// CHECK24-NOT: <decl.function.method.instance><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>unavailable</decl.name>()</decl.function.method.instance>

// RUN: %sourcekitd-test -req=cursor -pos=58:15 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK25 %s
// CHECK25: <Declaration>func availabilityIntroducedMsg()</Declaration>
// CHECK25: <decl.function.method.instance><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>availabilityIntroducedMsg</decl.name>()</decl.function.method.instance>

// RUN: %sourcekitd-test -req=cursor -pos=59:15 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK26 %s
// CHECK26-NOT: <Declaration>func availabilityDeprecated()</Declaration>
// CHECK26-NOT: <decl.function.method.instance><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>availabilityDeprecated</decl.name>()</decl.function.method.instance>

// RUN: %sourcekitd-test -req=cursor -pos=69:14 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK27 %s
// CHECK27: <Declaration>public subscript(i: <Type usr="s:Si">Int</Type>) -&gt; <Type usr="s:Si">Int</Type> { get }</Declaration>
// CHECK27: <decl.function.subscript><syntaxtype.keyword>public</syntaxtype.keyword> <syntaxtype.keyword>subscript</syntaxtype.keyword>(<decl.var.parameter><decl.var.parameter.name>i</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>) -&gt; <decl.function.returntype><ref.struct usr="s:Si">Int</ref.struct></decl.function.returntype> { <syntaxtype.keyword>get</syntaxtype.keyword> }</decl.function.subscript>

// RUN: %sourcekitd-test -req=cursor -pos=69:19 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK28 %s
// CHECK28: <Declaration>public subscript(i: <Type usr="s:Si">Int</Type>) -&gt; <Type usr="s:Si">Int</Type> { get }</Declaration>
// CHECK28: <decl.function.subscript><syntaxtype.keyword>public</syntaxtype.keyword> <syntaxtype.keyword>subscript</syntaxtype.keyword>(<decl.var.parameter><decl.var.parameter.name>i</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>) -&gt; <decl.function.returntype><ref.struct usr="s:Si">Int</ref.struct></decl.function.returntype> { <syntaxtype.keyword>get</syntaxtype.keyword> }</decl.function.subscript>

// RUN: %sourcekitd-test -req=cursor -pos=74:3 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK29
// CHECK29: source.lang.swift.decl.function.destructor (74:3-74:9)
// CHECK29-NEXT: deinit
// CHECK29-NEXT: s:FC11cursor_info2C3d
// CHECK29-NEXT: C3 -> ()
// CHECK29-NEXT: <Declaration>deinit</Declaration>
// CHECK29-NEXT: <decl.function.destructor><syntaxtype.keyword>deinit</syntaxtype.keyword></decl.function.destructor>

// RUN: %sourcekitd-test -req=cursor -pos=75:3 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK30
// CHECK30: source.lang.swift.decl.function.constructor (75:3-75:16)
// CHECK30-NEXT: init(x:)
// CHECK30-NEXT: s:FC11cursor_info2C3cFT1xSi_GSQS0__
// CHECK30-NEXT: C3.Type -> (x: Int) -> C3!
// CHECK30-NEXT: <Declaration>init!(x: <Type usr="s:Si">Int</Type>)</Declaration>
// CHECK30-NEXT: <decl.function.constructor><syntaxtype.keyword>init</syntaxtype.keyword>!(<decl.var.parameter><decl.var.parameter.argument_label>x</decl.var.parameter.argument_label>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>)</decl.function.constructor>

// RUN: %sourcekitd-test -req=cursor -pos=76:3 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK31
// CHECK31: source.lang.swift.decl.function.constructor (76:3-76:16)
// CHECK31-NEXT: init(y:)
// CHECK31-NEXT: s:FC11cursor_info2C3cFT1ySi_GSqS0__
// CHECK31-NEXT: C3.Type -> (y: Int) -> C3?
// CHECK31-NEXT: <Declaration>init?(y: <Type usr="s:Si">Int</Type>)</Declaration>
// CHECK31-NEXT: <decl.function.constructor><syntaxtype.keyword>init</syntaxtype.keyword>?(<decl.var.parameter><decl.var.parameter.argument_label>y</decl.var.parameter.argument_label>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>)</decl.function.constructor>

// RUN: %sourcekitd-test -req=cursor -pos=77:3 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK32
// CHECK32: source.lang.swift.decl.function.constructor (77:3-77:15)
// CHECK32-NEXT: init(z:)
// CHECK32-NEXT: s:FC11cursor_info2C3cFzT1zSi_S0_
// CHECK32-NEXT: C3.Type -> (z: Int) throws -> C3
// CHECK32-NEXT: <Declaration>init(z: <Type usr="s:Si">Int</Type>) throws</Declaration>
// CHECK32-NEXT: <decl.function.constructor><syntaxtype.keyword>init</syntaxtype.keyword>(<decl.var.parameter><decl.var.parameter.argument_label>z</decl.var.parameter.argument_label>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>) <syntaxtype.keyword>throws</syntaxtype.keyword></decl.function.constructor>

// RUN: %sourcekitd-test -req=cursor -pos=80:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK33
// CHECK33: source.lang.swift.decl.struct (80:8-80:10)
// CHECK33-NEXT: S2
// CHECK33-NEXT: s:V11cursor_info2S2
// CHECK33-NEXT: S2.Type
// CHECK33-NEXT: <Declaration>struct S2&lt;T, U&gt;</Declaration>
// CHECK33-NEXT: <decl.struct><syntaxtype.keyword>struct</syntaxtype.keyword> <decl.name>S2</decl.name>&lt;<decl.generic_type_param usr="s:tV11cursor_info2S21TMx"><decl.generic_type_param.name>T</decl.generic_type_param.name></decl.generic_type_param>, <decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>U</decl.generic_type_param.name></decl.generic_type_param>&gt;</decl.struct>

// RUN: %sourcekitd-test -req=cursor -pos=81:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK34
// CHECK34: source.lang.swift.decl.function.method.instance (81:8-81:48)
// CHECK34-NEXT: foo(_:)
// CHECK34-NEXT: s:FV11cursor_info2S23foou0_rFFT_T_FT_T_
// CHECK34-NEXT: <T, U> (S2<T, U>) -> <V, W> (() -> ()) -> () -> ()
// CHECK34-NEXT: <Declaration>func foo&lt;V, W&gt;(closure: () -&gt; ()) -&gt; () -&gt; ()</Declaration>
// CHECK34-NEXT: <decl.function.method.instance><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>foo</decl.name>&lt;<decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>V</decl.generic_type_param.name></decl.generic_type_param>, <decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>W</decl.generic_type_param.name></decl.generic_type_param>&gt;(<decl.var.parameter><decl.var.parameter.name>closure</decl.var.parameter.name>: <decl.var.parameter.type>() -&gt; <decl.function.returntype>()</decl.function.returntype></decl.var.parameter.type></decl.var.parameter>) -&gt; <decl.function.returntype>() -&gt; <decl.function.returntype>()</decl.function.returntype></decl.function.returntype></decl.function.method.instance>

// RUN: %sourcekitd-test -req=cursor -pos=83:7 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK35
// CHECK35: source.lang.swift.decl.class (83:7-83:9)
// CHECK35-NEXT: C4
// CHECK35-NEXT: s:C11cursor_info2C4
// CHECK35-NEXT: C4.Type
// CHECK35-NEXT: <Declaration>class C4&lt;T, U&gt;</Declaration>
// CHECK35-NEXT: <decl.class><syntaxtype.keyword>class</syntaxtype.keyword> <decl.name>C4</decl.name>&lt;<decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>T</decl.generic_type_param.name></decl.generic_type_param>, <decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>U</decl.generic_type_param.name></decl.generic_type_param>&gt;</decl.class>

// RUN: %sourcekitd-test -req=cursor -pos=84:6 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK36
// CHECK36: source.lang.swift.decl.enum (84:6-84:8)
// CHECK36-NEXT: E1
// CHECK36-NEXT: s:O11cursor_info2E1
// CHECK36-NEXT: E1.Type
// CHECK36-NEXT: <Declaration>enum E1&lt;T, U&gt;</Declaration>
// CHECK36-NEXT: <decl.enum><syntaxtype.keyword>enum</syntaxtype.keyword> <decl.name>E1</decl.name>&lt;<decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>T</decl.generic_type_param.name></decl.generic_type_param>, <decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>U</decl.generic_type_param.name></decl.generic_type_param>&gt;</decl.enum>

// RUN: %sourcekitd-test -req=cursor -pos=86:6 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK37
// CHECK37: source.lang.swift.decl.function.free (86:6-86:111)
// CHECK37-NEXT: nonDefaultArgNames(external1:_:external3:external4:_:)
// CHECK37-NEXT: s:F11cursor_info18nonDefaultArgNamesFT9external1SiSi9external3Si9external4SiSi_T_
// CHECK37-NEXT: (external1: Int, Int, external3: Int, external4: Int, Int) -> ()
// CHECK37-NEXT: <Declaration>func nonDefaultArgNames(external1 local1: <Type usr="s:Si">Int</Type>, _ local2: <Type usr="s:Si">Int</Type>, external3 local3: <Type usr="s:Si">Int</Type>, external4 _: <Type usr="s:Si">Int</Type>, _: <Type usr="s:Si">Int</Type>)</Declaration>
// CHECK37-NEXT: <decl.function.free><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>nonDefaultArgNames</decl.name>(<decl.var.parameter><decl.var.parameter.argument_label>external1</decl.var.parameter.argument_label> <decl.var.parameter.name>local1</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>, <decl.var.parameter><decl.var.parameter.argument_label>_</decl.var.parameter.argument_label> <decl.var.parameter.name>local2</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>, <decl.var.parameter><decl.var.parameter.argument_label>external3</decl.var.parameter.argument_label> <decl.var.parameter.name>local3</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>, <decl.var.parameter><decl.var.parameter.argument_label>external4</decl.var.parameter.argument_label> <decl.var.parameter.name>_</decl.var.parameter.name>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>, <decl.var.parameter><decl.var.parameter.argument_label>_</decl.var.parameter.argument_label>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>)</decl.function.free>

// RUN: %sourcekitd-test -req=cursor -pos=88:6 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK38
// CHECK38: <decl.function.free><syntaxtype.keyword>func</syntaxtype.keyword> <decl.name>nestedFunctionType</decl.name>(<decl.var.parameter><decl.var.parameter.name>closure</decl.var.parameter.name>: <decl.var.parameter.type>(<decl.var.parameter><decl.var.parameter.argument_label>y</decl.var.parameter.argument_label>: <decl.var.parameter.type>(<decl.var.parameter><decl.var.parameter.argument_label>z</decl.var.parameter.argument_label>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>) -&gt; <decl.function.returntype><ref.struct usr="s:Si">Int</ref.struct></decl.function.returntype></decl.var.parameter.type></decl.var.parameter>) -&gt; <decl.function.returntype><ref.struct usr="s:Si">Int</ref.struct></decl.function.returntype></decl.var.parameter.type></decl.var.parameter>) -&gt; <decl.function.returntype>(<decl.var.parameter><decl.var.parameter.argument_label>y</decl.var.parameter.argument_label>: <decl.var.parameter.type>(<decl.var.parameter><decl.var.parameter.argument_label>z</decl.var.parameter.argument_label>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>) -&gt; <decl.function.returntype><ref.struct usr="s:Si">Int</ref.struct></decl.function.returntype></decl.var.parameter.type></decl.var.parameter>) -&gt; <decl.function.returntype><ref.struct usr="s:Si">Int</ref.struct></decl.function.returntype></decl.function.returntype></decl.function.free>

// RUN: %sourcekitd-test -req=cursor -pos=91:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK39
// CHECK39: source.lang.swift.decl.enumelement (91:8-91:10)
// CHECK39-NEXT: C1
// CHECK39-NEXT: s:FO11cursor_info2E22C1FMS0_S0_
// CHECK39-NEXT: E2.Type -> E2
// CHECK39-NEXT: <Declaration>case C1</Declaration>
// CHECK39-NEXT: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>C1</decl.name></decl.enumelement>

// RUN: %sourcekitd-test -req=cursor -pos=92:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK40
// CHECK40: source.lang.swift.decl.enumelement (92:8-92:10)
// CHECK40-NEXT: C2
// CHECK40-NEXT: s:FO11cursor_info2E22C2FMS0_FT1xSi1ySS_S0_
// CHECK40-NEXT: E2.Type -> (x: Int, y: String) -> E2
// CHECK40-NEXT: <Declaration>case C2(x: <Type usr="s:Si">Int</Type>, y: <Type usr="s:SS">String</Type>)</Declaration>
// CHECK40-NEXT: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>C2</decl.name>(<tuple.element><tuple.element.argument_label>x</tuple.element.argument_label>: <tuple.element.type><ref.struct usr="s:Si">Int</ref.struct></tuple.element.type></tuple.element>, <tuple.element><tuple.element.argument_label>y</tuple.element.argument_label>: <tuple.element.type><ref.struct usr="s:SS">String</ref.struct></tuple.element.type></tuple.element>)</decl.enumelement>

// RUN: %sourcekitd-test -req=cursor -pos=92:31 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK41
// CHECK41: source.lang.swift.decl.enumelement (92:31-92:33)
// CHECK41-NEXT: C3
// CHECK41-NEXT: s:FO11cursor_info2E22C3FMS0_FSiS0_
// CHECK41-NEXT: E2.Type -> (Int) -> E2
// CHECK41-NEXT: <Declaration>case C3(<Type usr="s:Si">Int</Type>)</Declaration>
// CHECK41-NEXT: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>C3</decl.name>(<ref.struct usr="s:Si">Int</ref.struct>)</decl.enumelement>
// FIXME: Wrap parameters in <decl.var.parameter>

// RUN: %sourcekitd-test -req=cursor -pos=96:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK42
// CHECK42: source.lang.swift.decl.enumelement (96:8-96:9)
// CHECK42-NEXT: C
// CHECK42-NEXT: s:FO11cursor_info2E31CFMS0_S0_
// CHECK42-NEXT: E3.Type -> E3
// CHECK42-NEXT: <Declaration>case C = &quot;a&quot;</Declaration>
// CHECK42-NEXT: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>C</decl.name> = <syntaxtype.string>&quot;a&quot;</syntaxtype.string></decl.enumelement>

// RUN: %sourcekitd-test -req=cursor -pos=100:14 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK43
// CHECK43: source.lang.swift.ref.enumelement (91:8-91:10)
// CHECK43-NEXT: C1
// CHECK43: <Declaration>case C1</Declaration>
// CHECK43-NEXT: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>C1</decl.name></decl.enumelement>

// RUN: %sourcekitd-test -req=cursor -pos=101:14 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK44
// CHECK44: source.lang.swift.ref.enumelement (92:8-92:10)
// CHECK44-NEXT: C2
// CHECK44: <Declaration>case C2(x: <Type usr="s:Si">Int</Type>, y: <Type usr="s:SS">String</Type>)</Declaration>
// CHECK44-NEXT: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>C2</decl.name>(<tuple.element><tuple.element.argument_label>x</tuple.element.argument_label>: <tuple.element.type><ref

// RUN: %sourcekitd-test -req=cursor -pos=102:16 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK45
// CHECK45: source.lang.swift.ref.enumelement (92:8-92:10)
// CHECK45-NEXT: C2
// CHECK45: <Declaration>case C2(x: <Type usr="s:Si">Int</Type>, y: <Type usr="s:SS">String</Type>)</Declaration>
// CHECK45-NEXT: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>C2</decl.name>(<tuple.element><tuple.element.argument_label>x

// RUN: %sourcekitd-test -req=cursor -pos=103:16 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK46
// CHECK46: source.lang.swift.ref.enumelement (96:8-96:9)
// CHECK46-NEXT: C
// CHECK46: <Declaration>case C = &quot;a&quot;</Declaration>
// CHECK46-NEXT: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>C</decl.name> = <syntaxtype.string>&quot;a&quot;</syntaxtype.string></decl.enumelement>

// RUN: %sourcekitd-test -req=cursor -pos=80:11 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK47
// CHECK47: source.lang.swift.decl.generic_type_param (80:11-80:12)
// CHECK47-NEXT: T
// CHECK47-NEXT: s:tV11cursor_info2S21TMx
// CHECK47-NEXT: T.Type
// CHECK47-NEXT: <Declaration>T</Declaration>
// CHECK47-NEXT: <decl.generic_type_param><decl.generic_type_param.name>T</decl.generic_type_param.name></decl.generic_type_param>

// RUN: %sourcekitd-test -req=cursor -pos=107:14 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK48
// CHECK48: source.lang.swift.decl.var.static (107:14-107:16)
// CHECK48: <decl.var.static><syntaxtype.keyword>static</syntaxtype.keyword> <syntaxtype.keyword>var</syntaxtype.keyword>

// RUN: %sourcekitd-test -req=cursor -pos=108:19 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK49
// CHECK49: source.lang.swift.decl.var.class (108:19-108:21)
// CHECK49: <decl.var.class><syntaxtype.keyword>final</syntaxtype.keyword> <syntaxtype.keyword>class</syntaxtype.keyword> <syntaxtype.keyword>var</syntaxtype.keyword>

// RUN: %sourcekitd-test -req=cursor -pos=109:15 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK50
// CHECK50: source.lang.swift.decl.function.method.static (109:15-109:19)
// CHECK50: <decl.function.method.static><syntaxtype.keyword>static</syntaxtype.keyword> <syntaxtype.keyword>func</syntaxtype.keyword>

// RUN: %sourcekitd-test -req=cursor -pos=110:20 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK51
// CHECK51: source.lang.swift.decl.function.method.class (110:20-110:24)
// CHECK51: <decl.function.method.class><syntaxtype.keyword>final</syntaxtype.keyword> <syntaxtype.keyword>class</syntaxtype.keyword> <syntaxtype.keyword>func</syntaxtype.keyword>

// RUN: %sourcekitd-test -req=cursor -pos=117:6 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK52
// CHECK52: source.lang.swift.decl.function.free (117:6-117:49)
// CHECK52: <U, V : P1 where V.T == U> (U, v: V) -> ()
// CHECK52: &lt;<decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>U</decl.generic_type_param.name></decl.generic_type_param>, <decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>V</decl.generic_type_param.name> : <decl.generic_type_param.constraint><ref.protocol usr="{{.*}}">P1</ref.protocol></decl.generic_type_param.constraint></decl.generic_type_param> <syntaxtype.keyword>where</syntaxtype.keyword> <decl.generic_type_requirement><ref.generic_type_param usr="{{.*}}">V</ref.generic_type_param>.<ref.associatedtype usr="{{.*}}">T</ref.associatedtype> == <ref.generic_type_param usr="{{.*}}">U</ref.generic_type_param></decl.generic_type_requirement>&gt;

// RUN: %sourcekitd-test -req=cursor -pos=117:16 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK53
// CHECK53: source.lang.swift.decl.generic_type_param (117:16-117:17)
// CHECK53: <decl.generic_type_param><decl.generic_type_param.name>V</decl.generic_type_param.name> : <decl.generic_type_param.constraint><ref.protocol usr="{{.*}}">P1</ref.protocol></decl.generic_type_param.constraint></decl.generic_type_param>

// RUN: %sourcekitd-test -req=cursor -pos=119:13 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK54
// CHECK54: source.lang.swift.decl.class (119:13-119:15)
// CHECK54: <decl.class><syntaxtype.attribute.builtin><syntaxtype.attribute.name>@objc</syntaxtype.attribute.name></syntaxtype.attribute.builtin> <syntaxtype.keyword>class

// RUN: %sourcekitd-test -req=cursor -pos=122:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK55
// CHECK55: source.lang.swift.decl.function.method.instance (122:8-122:12)
// CHECK55: <decl.function.method.instance><syntaxtype.attribute.builtin><syntaxtype.attribute.name>@objc</syntaxtype.attribute.name>(mmm1)</syntaxtype.attribute.builtin> <syntaxtype.attribute.builtin><syntaxtype.attribute.name>@noreturn</syntaxtype.attribute.name></syntaxtype.attribute.builtin> <syntaxtype.keyword>func

// RUN: %sourcekitd-test -req=cursor -pos=126:7 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK56
// CHECK56: source.lang.swift.decl.var.instance (126:7-126:9)
// CHECK56: <decl.var.instance><syntaxtype.keyword>private</syntaxtype.keyword>(set) <syntaxtype.keyword>public</syntaxtype.keyword> <syntaxtype.keyword>var

// RUN: %sourcekitd-test -req=cursor -pos=129:5 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK57
// CHECK57: source.lang.swift.decl.var.global (129:5-129:14)
// CHECK57: <decl.var.global><syntaxtype.keyword>let</syntaxtype.keyword> <decl.name>tupleVar1</decl.name>: <decl.var.type>(<tuple.element><tuple.element.type>(<tuple.element><tuple.element.type>(<tuple.element><tuple.element.type><ref.struct usr="s:Si">Int</ref.struct></tuple.element.type></tuple.element>, <tuple.element><tuple.element.type><ref.struct usr="s:Si">Int</ref.struct></tuple.element.type></tuple.element>)</tuple.element.type></tuple.element>, <tuple.element><tuple.element.argument_label>y</tuple.element.argument_label>: <tuple.element.type><ref.struct usr="s:Si">Int</ref.struct></tuple.element.type></tuple.element>)</tuple.element.type></tuple.element>, <tuple.element><tuple.element.argument_label>z</tuple.element.argument_label>: <tuple.element.type><ref.struct usr="s:Si">Int</ref.struct></tuple.element.type></tuple.element>)</decl.var.type></decl.var.global>

// RUN: %sourcekitd-test -req=cursor -pos=130:5 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK58
// CHECK58: source.lang.swift.decl.var.global (130:5-130:14)
// CHECK58: <decl.var.global><syntaxtype.keyword>let</syntaxtype.keyword> <decl.name>tupleVar2</decl.name>: <decl.var.type>(<tuple.element><tuple.element.argument_label>f</tuple.element.argument_label>: <tuple.element.type>() -&gt; <decl.function.returntype>()</decl.function.returntype></tuple.element.type></tuple.element>, <tuple.element><tuple.element.argument_label>g</tuple.element.argument_label>: <tuple.element.type>(<decl.var.parameter><decl.var.parameter.argument_label>x</decl.var.parameter.argument_label>: <decl.var.parameter.type><ref.struct usr="s:Si">Int</ref.struct></decl.var.parameter.type></decl.var.parameter>) -&gt; <decl.function.returntype><ref.struct usr="s:Si">Int</ref.struct></decl.function.returntype></tuple.element.type></tuple.element>)</decl.var.type></decl.var.global>

// RUN: %sourcekitd-test -req=cursor -pos=131:5 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK59
// CHECK59: source.lang.swift.decl.var.global (131:5-131:14)
// CHECK59: <decl.var.global><syntaxtype.keyword>let</syntaxtype.keyword> <decl.name>tupleVar3</decl.name>: <decl.var.type>(<tuple.element><tuple.element.argument_label>f</tuple.element.argument_label>: <tuple.element.type>(<decl.var.parameter><decl.var.parameter.argument_label>x</decl.var.parameter.argument_label>: <decl.var.parameter.type><syntaxtype.keyword>inout</syntaxtype.keyword> (<tuple.element><tuple.element.type><ref.struct usr="s:Si">Int</ref.struct></tuple.element.type></tuple.element>, <tuple.element><tuple.element.type><ref.struct usr="s:Si">Int</ref.struct></tuple.element.type></tuple.element>)</decl.var.parameter.type></decl.var.parameter>) <syntaxtype.keyword>throws</syntaxtype.keyword> -&gt; <decl.function.returntype>()</decl.function.returntype></tuple.element.type></tuple.element>, <tuple.element><tuple.element.type><ref.struct usr="s:Si">Int</ref.struct></tuple.element.type></tuple.element>)</decl.var.type></decl.var.global>

// RUN: %sourcekitd-test -req=cursor -pos=134:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK60
// CHECK60: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>A</decl.name> = <syntaxtype.number>-1</syntaxtype.number></decl.enumelement>
// RUN: %sourcekitd-test -req=cursor -pos=135:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK61
// CHECK61: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>B</decl.name> = <syntaxtype.number>0</syntaxtype.number></decl.enumelement>
// RUN: %sourcekitd-test -req=cursor -pos=136:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK62
// CHECK62: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>C</decl.name> = <syntaxtype.number>1</syntaxtype.number></decl.enumelement>

// RUN: %sourcekitd-test -req=cursor -pos=142:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK63
// CHECK63: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>A</decl.name> = <syntaxtype.number>-0.0</syntaxtype.number></decl.enumelement>
// RUN: %sourcekitd-test -req=cursor -pos=143:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK64
// CHECK64: <decl.enumelement><syntaxtype.keyword>case</syntaxtype.keyword> <decl.name>B</decl.name> = <syntaxtype.number>1e10</syntaxtype.number></decl.enumelement>

// RUN: %sourcekitd-test -req=cursor -pos=146:7 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK65
// CHECK65: <decl.class><syntaxtype.keyword>class</syntaxtype.keyword> <decl.name>C6</decl.name> : C4, <ref.protocol usr="s:P11cursor_info2P1">P1</ref.protocol></decl.class>
// FIXME: ref.class - rdar://problem/25014968

// RUN: %sourcekitd-test -req=cursor -pos=150:10 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK66
// CHECK66: <decl.protocol><syntaxtype.keyword>protocol</syntaxtype.keyword> <decl.name>P2</decl.name> :  <syntaxtype.keyword>class</syntaxtype.keyword>, <ref.protocol usr="s:P11cursor_info2P1">P1</ref.protocol></decl.protocol>

// RUN: %sourcekitd-test -req=cursor -pos=114:18 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK67
// CHECK67: source.lang.swift.decl.associatedtype (114:18-114:19)
// CHECK67-NEXT: T
// CHECK67-NEXT: s:P11cursor_info2P11T
// CHECK67-NEXT: T.Type
// CHECK67-NEXT: <Declaration>associatedtype T</Declaration>
// CHECK67-NEXT: <decl.associatedtype><syntaxtype.keyword>associatedtype</syntaxtype.keyword> <decl.name>T</decl.name></decl.associatedtype>

// RUN: %sourcekitd-test -req=cursor -pos=152:11 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK68
// CHECK68: source.lang.swift.decl.typealias (152:11-152:18)
// CHECK68-NEXT: MyAlias
// CHECK68-NEXT: s:11cursor_info7MyAlias
// CHECK68-NEXT: MyAlias.Type
// CHECK68-NEXT: <Declaration>typealias MyAlias&lt;T, U&gt; = (<Type usr="{{.*}}">T</Type>, <Type usr="{{.*}}">U</Type>, <Type usr="{{.*}}">T</Type>, <Type usr="{{.*}}">U</Type>)</Declaration>
// CHECK68-NEXT: <decl.typealias><syntaxtype.keyword>typealias</syntaxtype.keyword> <decl.name>MyAlias</decl.name>&lt;<decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>T</decl.generic_type_param.name></decl.generic_type_param>, <decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>U</decl.generic_type_param.name></decl.generic_type_param>&gt; = (<tuple.element><tuple.element.type><ref.generic_type_param usr="{{.*}}">T</ref.generic_type_param></tuple.element.type></tuple.element>, <tuple.element><tuple.element.type><ref.generic_type_param usr="{{.*}}">U</ref.generic_type_param></tuple.element.type></tuple.element>, <tuple.element><tuple.element.type><ref.generic_type_param usr="{{.*}}">T</ref.generic_type_param></tuple.element.type></tuple.element>, <tuple.element><tuple.element.type><ref.generic_type_param usr="{{.*}}">U</ref.generic_type_param></tuple.element.type></tuple.element>)</decl.typealias>

// RUN: %sourcekitd-test -req=cursor -pos=153:28 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK69
// CHECK69: source.lang.swift.ref.typealias (152:11-152:18)
// CHECK69-NEXT: MyAlias
// CHECK69-NEXT: s:11cursor_info7MyAlias
// CHECK69-NEXT: MyAlias.Type
// CHECK69-NEXT: <Declaration>typealias MyAlias&lt;T, U&gt; = (<Type usr="{{.*}}">T</Type>, <Type usr="{{.*}}">U</Type>, <Type usr="{{.*}}">T</Type>, <Type usr="{{.*}}">U</Type>)</Declaration>
// CHECK69-NEXT: <decl.typealias><syntaxtype.keyword>typealias</syntaxtype.keyword> <decl.name>MyAlias</decl.name>&lt;<decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>T</decl.generic_type_param.name></decl.generic_type_param>, <decl.generic_type_param usr="{{.*}}"><decl.generic_type_param.name>U</decl.generic_type_param.name></decl.generic_type_param>&gt; = (<tuple.element><tuple.element.type><ref.generic_type_param usr="{{.*}}">T</ref.generic_type_param></tuple.element.type></tuple.element>, <tuple.element><tuple.element.type><ref.generic_type_param usr="{{.*}}">U</ref.generic_type_param></tuple.element.type></tuple.element>, <tuple.element><tuple.element.type><ref.generic_type_param usr="{{.*}}">T</ref.generic_type_param></tuple.element.type></tuple.element>, <tuple.element><tuple.element.type><ref.generic_type_param usr="{{.*}}">U</ref.generic_type_param></tuple.element.type></tuple.element>)</decl.typealias>

// RUN: %sourcekitd-test -req=cursor -pos=155:6 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK70
// CHECK70: <decl.var.parameter><syntaxtype.attribute.builtin><syntaxtype.attribute.name>@noescape</syntaxtype.attribute.name></syntaxtype.attribute.builtin> <decl.var.parameter.name>

// RUN: %sourcekitd-test -req=cursor -pos=156:6 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK71
// CHECK71: <decl.var.parameter><syntaxtype.attribute.builtin><syntaxtype.attribute.name>@autoclosure</syntaxtype.attribute.name></syntaxtype.attribute.builtin> <decl.var.parameter.name>

// RUN: %sourcekitd-test -req=cursor -pos=157:6 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK72
// CHECK72: <decl.var.parameter><syntaxtype.attribute.builtin><syntaxtype.attribute.name>@autoclosure</syntaxtype.attribute.name>(escaping)</syntaxtype.attribute.builtin> <decl.var.parameter.name>

// RUN: %sourcekitd-test -req=cursor -pos=159:6 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK73
// CHECK73: <decl.function.free>
// CHECK73-SAME: = <syntaxtype.keyword>#function</syntaxtype.keyword>
// CHECK73-SAME: = <syntaxtype.keyword>#file</syntaxtype.keyword>
// CHECK73-SAME: = <syntaxtype.keyword>#line</syntaxtype.keyword>
// CHECK73-SAME: = <syntaxtype.keyword>#column</syntaxtype.keyword>
// FIXME: []
// CHECK73-SAME: = <syntaxtype.keyword>default</syntaxtype.keyword>
// FIXME: [:]
// CHECK73-SAME: = <syntaxtype.keyword>default</syntaxtype.keyword>
// FIXME: keyword nil
// CHECK73-SAME: = <syntaxtype.keyword>default</syntaxtype.keyword>
// CHECK73-SAME: = <syntaxtype.keyword>default</syntaxtype.keyword>

// RUN: %sourcekitd-test -req=cursor -pos=162:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK74
// CHECK74: source.lang.swift.decl.function.method.instance (162:8-162:18)
// CHECK74: <Self : P3> (Self) -> (Self) -> Self
// CHECK74: <Declaration>func f(s: <Type usr="s:tP11cursor_info2P34SelfMx">Self</Type>) -&gt; <Type usr="s:tP11cursor_info2P34SelfMx">Self</Type></Declaration>
// CHECK74: <decl.var.parameter.type><ref.generic_type_param usr="s:tP11cursor_info2P34SelfMx">Self</ref.generic_type_param></decl.var.parameter.type>
// CHECK74-SAME: <decl.function.returntype><ref.generic_type_param usr="s:tP11cursor_info2P34SelfMx">Self</ref.generic_type_param></decl.function.returntype>

// RUN: %sourcekitd-test -req=cursor -pos=165:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK75
// CHECK75: source.lang.swift.decl.function.method.instance (165:8-165:18)
// CHECK75: <Self : P3> (Self) -> (Self) -> Self
// CHECK75: <Declaration>func f(s: <Type usr="s:tE11cursor_infoPS_2P34SelfMx">Self</Type>) -&gt; <Type usr="s:tP11cursor_info2P34SelfMx">Self</Type></Declaration>
// CHECK75: <decl.var.parameter.type><ref.generic_type_param usr="s:tE11cursor_infoPS_2P34SelfMx">Self</ref.generic_type_param></decl.var.parameter.type>
// CHECK75-SAME: <decl.function.returntype><ref.generic_type_param usr="s:tP11cursor_info2P34SelfMx">Self</ref.generic_type_param></decl.function.returntype>
// FIXME: the return type gets the USR for the original protocol, rather than the extension.

// RUN: %sourcekitd-test -req=cursor -pos=169:8 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck %s -check-prefix=CHECK76
// CHECK76: source.lang.swift.decl.function.method.instance (169:8-169:11)
// CHECK76: (Self) -> () -> Self
// CHECK76: <Declaration>func f() -&gt; <Type usr="s:C11cursor_info2C7">Self</Type></Declaration>
// CHECK76: <decl.function.returntype><ref.class usr="s:C11cursor_info2C7">Self</ref.class></decl.function.returntype>

// RUN: %sourcekitd-test -req=cursor -pos=178:10 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK77 %s
// CHECK77-NOT: @warn_unused_result

// RUN: %sourcekitd-test -req=cursor -pos=197:7 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK78 %s
// RUN: %sourcekitd-test -req=cursor -pos=198:7 %s -- -F %S/../Inputs/libIDE-mock-sdk -I %t.tmp %mcp_opt %s | FileCheck -check-prefix=CHECK79 %s

// CHECK78: foo1 comment from P4
// CHECK79: foo2 comment from C1