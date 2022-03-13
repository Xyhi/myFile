412：9-7 20:00

### Java面向对象高级

#### 类变量和类方法

##### 类变量

###### 介绍、定义、访问

* 介绍

类变量也叫静态变量/静态属性，是该类的所有对象共享的变量，任何一个该类的对象去访问它时，取到的都是相同的值，同样任何一个该类的对象去修改它时，修改的也是同一个变量

>```Java
>class Child{
>//如count会在方法区中根类信息一起被加载，即在对象被创建之前，所以所有的child实例均会共享这片       内存地址，所有count成为所有child实例共有的变量(类变量/静态变量)
>public static int count = 0;
>...
>}
>```

* 类变量定义

>访问修饰符 static 数据类型 变量名

* 访问类变量

>类名.类变量   或者   对象名.类变量
>
>***ps: 由于类变量是随类的加载而创建，所以即使没有创建对象实例，也可以直接通过==类.类变量==的形式进行访问***

###### 类变量内存布局

>注意会由于jdk的版本不同而有所不同
>
>1. 在jdk7之前，类变量会存储在方法区中，同类的信息一起进行加载
>
>2. 在jdk7之后，静态变量会在通过反射机制，在Class实例的尾部，而Class对象是存储在堆中
>
>3. 总而言之，有两点共识
>
>   >* static变量是同一个类所有对象实例共享
>   >* static类变量，在类加载的时候就生成了

###### 类变量使用事项和细节

>1. 什么时候需要使用类变量
>
>   >当我们需要让某个类的所有对象都共享一个变量时，就可以考虑使用类变量，比如定义学生类，统计所有学生需要交的钱
>
>2. 类变量与实例变量的区别
>
>   >* 类变量是该类的所有对象共享的，随着类的加载而创建
>   >* 实例变量是每个对象专有的，需要随对象的创建而创建
>
>3. 加上static称为类变量或静态变量，否则称为实例变量/普通变量/非静态变量
>
>4. 类变量可以通过==类名.类变量==或==对象名.类变量==来进行访问，但是java设计者更加推荐使用==***类名.类变量***==
>
>5. 类变量的声明周期是随类的加载而开始，随着类消亡而销毁

##### 类方法

###### 类方法经典的使用场景

>当方法中不涉及到任何和对象相关的成员，则可以将方法设计为静态方法，提高开发效率
>
>比如很多工具类$Math类、Arrays类、Collections集合类$等
>
>在实际开发中，往往会将一些通用的方法设计为静态方法，如打印一维数组，冒泡排序，完成某个计算任务等

###### 类方法使用事项和细节

>1. 类方法和普通方法都是随着类的加载而加载，将结构信息存储在方法区
>
>   >* <u>**类方法中没有this参数，所以不依赖对象来调用**</u>$\Rightarrow$不能在一个静态方法中引用非静态成员
>   >
>   >* <u>**普通方法中隐含着this参数**</u>
>
>2. 类方法可以通过类名调用，也可以通过对象名调用
>
>3. 普通方法和对象有关，需要通过对象名调用
>
>4. 类方法中不允许使用和对象有关的关键字，如 <u>***this和super***</u>
>
>5. 类方法(静态方法)中只能访问<font color="#212891"><u>***静态变量或静态方法***</u></font>
>
>6. 普通成员方法，既可以访问 非静态成员，也可以访问静态变量成员

#### 理解main方法语法

##### 深入理解main方法

###### 解释main方法的形式

>```Java
>public static void main(String[] args){}
>```
>
>1. java虚拟机需要调用类的main()方法，所以方法的访问权限必须是public
>
>   <u><font color="black">*因为java虚拟机jvm与main方法并不处于同一个类中*</font></u>
>
>2. java虚拟机在执行main()方法时不必创建对象，所以方法必须是静态方法
>
>3. 该方法接收String类型的数组参数，该数组中保存执行java命令时传递给所运行类的参数
>
><img src="C:\Users\020227\Desktop\大二上技术进程\韩顺平java\Java面向对象\007.jpg" style="zoom:40%;" />

###### 注意事项和细节

>1. 在main()方法中，我们可以直接调用main方法所在类的静态方法或属性
>2. 但是，不能直接访问该类中的非静态成员，必须创建该类的一个实例对象后，才能通过这个对象去访问类中的非静态成员
>

###### main动态传值

#### 代码块

##### 基本介绍

>* 代码块又称为初始化块，属于类中的成员[是类的一部分]，类似于方法，将逻辑语句封装在方法体中，通过{}包围起来
>* 但和方法不同，没有方法名，没有返回值，没有参数，只有方法体，而且不能通过对象或者类显式地调用，而是加载类时，或创建对象时隐式调用

##### 基本语法

>```java
>[修饰符]{
>    代码
>};
>```
>
>1. 修饰符可选，要写的话，只能写static
>2. 代码块分为两类，使用static修饰的叫静态代码块，没有static修饰的叫普通代码块
>3. 逻辑语句可以为任意逻辑语句(输入、输出、方法调用、循环、判断等)
>4. ;号可以写上，也可以省略

##### 作用

>1. 相当于另外一种形式的构造器(对构造器的补充机制)，可以做初始化的操作
>
>2. 如果多个构造器中都有重复的语句，可以抽取到初始化块中，提高代码的重用性
>
>3. 代码块的快速入门
>
>   ```Java
>   {
>       //这样我们不管调用哪个构造器，创建对象都会先调用代码块的内容
>       
>       System.out.println("-----");
>       System.out.println(".....");
>   }
>   public Movie(String name){
>       ...
>   }
>   public Movie(String name, double price){
>       ...
>   }
>   public Movie(String name, double price, int profit){
>       
>   }
>   ```
>
>4. 代码块调用的顺序优先于构造器
>

##### 代码块细节讨论

>1. static代码块也叫静态代码块，作用就是对==类进行初始化==，而且它随着类的加载而执行，并且只会==**执行一次**==，如果是普通代码块，每创建一个对象就会执行
>
>2. <u>**类什么时候被加载**</u>
>
>   >* 创建对象实例时(new)
>   >* 创建==子类对象==，父类也会被加载
>   >* 使用==类的静态成员==时(静态属性，静态方法)
>   >
>   >```Java
>   >public class test002 {
>   >    public static void main(String[] args) {
>   >        //new，同时A的父类B中的代码块也会被执行
>   >        A a = new A();
>   >        //调用类.静态成员
>   >        System.out.println(A.n);
>   >    }
>   >}
>   >
>   >class B{
>   >    {
>   >        System.out.println("B is codeblock");
>   >    }
>   >}
>   >
>   >class A extends B{
>   >    public static int n = 1;
>   >    static{
>   >        System.out.println("A is codeblock");
>   >    }
>   >}
>
>3. 普通的代码块，在创建对象实例时，会被隐式的调用。被创建一次调用一次。如果只是使用==**类的静态成员**==时，普通代码块并不会执行。普通代码块在new对象时，被调用，而且是每创建一次，就调用一次，所以可以简单地理解普通代码块就是构造器的补充
>
>4. 创建一个对象时，在一个类的调用顺序是(难点、重点):
>
>   >* 调用==静态代码块和静态属性初始化==时（注意：静态代码块和静态属性初始化调用的优先级一样，如果有多个静态代码块和多个静态变量初始化，则按他们定义的顺序调用）
>   >
>   >```java
>   >public class test002 {
>   >    public static void main(String[] args) {
>   >        A a = new A();
>   >    }
>   >}
>   >
>   >class A {
>   >    private static int n1 = getN1();
>   >    static {
>   >        System.out.println("A 静态代码块");
>   >    }
>   >    public static int getN1(){
>   >        System.out.println("getN1被调用");
>   >        return 100;
>   >    }
>   >}
>   >OutPut:
>   >getN1被调用
>   >A 静态代码块
>   >```
>   >
>   >* 调用普通代码块和普通属性的初始化(注意：普通代码块和普通属性初始化调用的优先级一样，如果有多个普通代码块和多个普通属性初始化，则按定义顺序调用)
>   >* 调用==构造方法/构造器==(在代码块执行之后)
>
>5. 构造方法(构造器)的前面实际上是隐含了super()和调用普通代码块，新写一个类演示，静态相关的代码块，属性初始化，在类加载时，就执行完毕。因此是优先于构造器和普通代码块执行
>
>   >父类构造器被调用
>   >
>   >子类的普通代码块和普通属性初始化被调用
>   >
>   >子类的构造器被调用
>
>6. 创建一个子类时(继承关系)，其静态代码块，静态属性初始化，普通代码块，普通属性初始化，构造方法的==***调用顺序***==如下：
>
>   >1. **父类的静态代码块和静态属性初始化(优先级一样，按定义顺序执行)**
>   >2. **子类的静态代码块和静态属性初始化(优先级一样，按定义顺序执行)**
>   >3. **父类的普通代码块和普通属性初始化(优先级一样，按定义顺序执行)**
>   >4. **父类的构造方法**
>   >5. **子类的普通代码块和普通属性初始化(优先级一样，按定义顺序执行)**
>   >6. **子类的构造方法**
>
>   ```java
>   public class test002 {
>       public static void main(String[] args) {
>           C c = new C();
>       }
>   }
>   class A {
>       static {
>           System.out.println("A的静态代码块被执行");
>       }
>       {
>           System.out.println("A的普通代码块被执行");
>       }
>       public A(){
>           System.out.println("A的构造器被执行");
>       }
>   }
>   
>   class B extends A {
>       static {
>           System.out.println("B的静态代码块被执行");
>       }
>       {
>           System.out.println("B的普通代码块被执行");
>       }
>       public B(){
>           System.out.println("B的构造器被执行");
>       }
>   }
>   class C extends B {
>       static {
>           System.out.println("C的静态代码块被执行");
>       }
>       {
>           System.out.println("C的普通代码块被执行");
>       }
>       public C(){
>           System.out.println("C的构造器被执行");
>       }
>   }
>   Output:
>   A的静态代码块被执行
>   B的静态代码块被执行
>   C的静态代码块被执行
>   A的普通代码块被执行
>   A的构造器被执行
>   B的普通代码块被执行
>   B的构造器被执行
>   C的普通代码块被执行
>   C的构造器被执行
>   
>   //先进行类的加载
>   A.static --> B.static --> C.static --> 
>   //再进行对象的创建    
>   A.norm --> A.constructor --> B.norm
>   --> B.constructor --> C.norm ---> C.constructor
>
>7. 静态代码块只能直接调用静态成员(静态属性和静态方法)，普通代码块可以调用任意成员
>
>8. 要非常注意静态属性初始化同静态代码块一样只会在类加载时执行一次，在类被加载完成后，不会执行第二次
>
>   ```java
>   public class test002 {
>       public static void main(String[] args) {
>           System.out.println("total = " + Persons.total);
>           System.out.println("total = " + Persons.total);
>       }
>   }
>   class Persons{
>       public static int total = setTotal();
>       static {
>           total = 100;
>           System.out.println("in static blocks");
>       }
>       public static int setTotal(){
>           System.out.println("static initialize");
>           return 0;
>       }
>   }
>   OutPut:
>   static initialize
>   in static blocks
>   total = 100
>   total = 100
>   ```
>
>   ```java
>   public class test002 {
>       public static void main(String[] args) {
>           Tests tests = new Tests();
>       }
>   }
>   class Sample{
>       Sample(String s){
>           System.out.println(s);
>       }
>       Sample(){
>           System.out.println("Sample默认的构造函数被调用");
>       }
>   }
>   class Tests{
>       Sample sam1 = new Sample("sam1成员初始化");
>       static Sample sam = new Sample("静态成员sam初始化");
>       static{
>           System.out.println("static块执行");
>           if(sam == null){
>               System.out.println("sam is null");
>           }
>       }
>       Tests(){
>           System.out.println("Test默认构造函数被调用");
>       }
>   }
>   OutPut:
>   静态成员sam初始化
>   static块执行
>   sam1成员初始化
>   Test默认构造函数被调用

#### 单例设计模式

##### 设计模式

>1. 静态方法和属性的经典使用
>
>2. 设计模式是在大量的实践中总结和理论化之后优选的代码结构、编程风格、以及解决问题的思考方式，设计模式就像是经典的棋谱，不同的棋局，我们用不同的棋谱，免去我们再思考和探索

##### 单例模式

>1. 所谓类的单例设计模式，就是采取一定的方法保证在整个的软件系统中，对某个类只能存在一个对象实例，并且该类只提供一个取得其对象实例的方法

###### 饿汉式

>1. 构造器私有化 ---> 防止用户通过new方式
>
>2. 类的内部创建对象
>
>3. 向外暴露一个静态的公共方法
>
>4. 代码实现(初级版本)
>
>5. 优点与缺点：要在线程安全方面进一步说明
>
>   ```java
>   class GirlFriend{
>       //将构造器私有化
>       //在类的内部直接创建
>       //提供一个公共的static方法可以返回构造的对象
>       private String name;
>       //为啥是public static，因为我们是要在共有的静态方法中返回该实例，所以在类的内部构造的       实例一定是static的
>       //可能造成创建了对象但是没有使用，导致了资源的浪费
>       private static GirlFriend gf = new GirlFriend("小红");
>       private GirlFriend(String name){
>           this.name = name;
>       }
>       public static GirlFriend getInstance(){
>           return gf;
>       }
>   }
>   ```

###### 懒汉式

>线程不安全
>
>```Java
>class GirlFriend{
>    private String name;
>    
>    private static GirlFriend gf = null;
>    private GrilFriend(String name){
>        if(gf == null){
>            gf = new GirlFriend("小红");
>        }
>        return gf;
>    }
>    
>}
>```

###### 饿汉式 vs 懒汉式

|        | 创建对象的时机           | 线程安全                                 | 资源浪费                                         |
| ------ | ------------------------ | ---------------------------------------- | ------------------------------------------------ |
| 饿汉式 | 在类加载时创建了对象实例 | 不存在线程安全问题                       | 当程序员一个对象实例都没有使用时，会导致资源浪费 |
| 懒汉式 | 在使用时创建对象实例     | 需要通过设置同步锁，才能解决线程安全问题 | 是使用时才创建，不会出现资源浪费问题             |

java.lang.Runtime就是典型的单例模式

#### final关键字

##### 基本介绍

>final：最后的，最终的
>
>final可以修饰类、属性、方法和局部变量

##### 情况分析

>1. 当不希望类被继承时，可以用final修饰
>2. 当不希望父类的某个方法被子类覆盖/重写(override)时，可以用final关键字修饰
>3. 当不希望类的某个属性的值被修改，可以使用final
>4. 当不希望某个局部变量被修改，可以使用final

##### 注意事项和使用细节

>1. final修饰的属性又叫常量，一般用大写字母来命名：XX_XX_XXX
>
>2. final修饰的属性在定义时，必须赋初值，并且以后不能再修改，复制可以在如下位置之一(但只能赋值一次，即三个位置必须只选择一个)
>
>  >* 定义时：public final double TAX_RATE = 0.08
>  >* 在构造器中
>  >* 在代码块中
>
>  ```java
>  class A{
>      public final double x = 2;
>      A{
>          x = 1;
>      }
>      {
>          x = 2; 
>      }
>  }
>  ```
>
>3. 如果final修饰的属性是静态的，则初始化只能在
>
>  >* 定义时
>  >
>  >* 在静态代码块中，不能在构造器中赋值(构造器依靠对象的创建，然而static的属性需要在类加载的过程中初始化，所以会造成static属性无法初始化，所以会报错)
>  >
>  >  ```java
>  >  class B{
>  >      public static final int TAX_RATE;
>  >      public B {
>  >          TAX_RATE = 8.8;
>  >      }
>  >      //此时编译器会报错
>  >  }
>
>4. final类不能继承，但是可以实例化对象
>
>5. 如果类不是final类，但是含有final方法，则该方法虽然不能重写，但是可以被继承
>
>6. 一般来说，如果一个类已经是final类了，就没有必要再将方法修饰成final方法
>
>7. final不能修饰构造器(构造方法)
>
>8. final和static往往搭配使用，效率更高，不会导致类的加载，底层编译器作了优化处理
>
>   ```java
>   main(
>       sout(B.num1); //调用时static代码块也会执行，即进行了类的加载
>       sout(B.num2); //不会导致类的加载
>   )
>   
>   class B {
>       public static int num1 = 1;
>       public final static int num2 = 2; 
>       static{
>           sout("呵呵");
>       }
>   }
>
>9. 包装类(Integer,Double,Float,Boolean等都是final)，String也是final类
>

#### 抽象类

##### 基本介绍

>当父类的方法定义具有不确定性 $\Rightarrow$ 考虑将该方法设计为抽象(abstract)方法 $\Rightarrow$ 所谓抽象方法就是没有实现的方法 $\Rightarrow$ 所有没有实现就是指没有方法体 $\Rightarrow$ 当一个类中存在abstract方法时，需要将该类声明为abstract类
>
>$\Rightarrow$ 一般来说抽象类会被子类继承，由子类来实现具体的抽象方法
>
>```java
>abstract class A {
>    public abstract void eat();
>}
>```

##### 系统介绍

>1. 用abstract关键字来修饰一个类时，这个类就叫抽象类
>
>   访问修饰符 abstract 类名{}
>
>2. 用abstract关键字来修饰一个方法时，这个方法就是抽象方法
>
>   访问修饰符 abstract 返回类型 方法名(形参列表);   // 没有方法体
>
>3. 抽象类的价值更多作用是在于设计，是设计者设计好后，让子类继承并实现抽象类
>
>4. 抽象类，是考官比较爱问的知识点，在框架和设计模式使用较多

##### 抽象类使用细节

>1. 抽象类不能被实例化
>
>2. 抽象类不一定要包含abstract方法，也就是说，抽象类可以没有abstract方法
>
>3. 一旦类包含了==abstract方法==，则这个类必须==声明为abstract==
>
>4. abstract只能修饰类和方法，不能修饰属性和其他的
>
>5. 抽象类可以有任意成员：比如非抽象方法、构造器、静态属性等
>
>6. 抽象方法不能有主体，即不能实现
>
>   ```java
>   abstract void saa(){};    //错误，不能有方法体
>   ```
>
>7. 如果一个类继承了抽象类，则它必须==实现抽象类的所有抽象方法==，除非它自己也声明为abstract类
>
>   ```java
>   abstract class MM {
>       public abstract void f1();
>       public abstract void f2();
>   }
>   
>   class NN extends MM{
>   
>       @Override
>       public void f1() {
>       }
>       @Override
>       public void f2() {
>       }
>   }
>   
>   abstract class PP extends MM{
>   }
>   ```
>
>8. 抽象类不能使用**==private、final和static==**来修饰，因为这些关键字都是和重写相违背的

##### 模板设计模式

>```java
>abstract class A{
>    public abstract void job();
>    public void caleTimes(){
>        long start = System.currentTimeMillis();
>        job();
>        long end = System.currentTimeMillis();
>        System.out.println("耗时" + (end - start));
>    }
>}、
>public class AA extends A{
>        public void job(){
>            ...
>        }
>}
>```

#### 接口

##### 快速入门

>```java
>interface Usb{
>    public void start();
>    public void stop();
>}
>class Camera implements Usb{
>    public void start(){
>        ...
>    }
>    public void stop(){
>        ...
>    }  
>}
>class Phone implements Usb{
>    public void start(){
>        ...
>    }
>    public void stop(){
>        ...
>    } 
>}
>class Computer{
>    public void working(Usb usb){
>        usb.start();
>        usb.stop();
>    }
>}
>main(){
>    Camera camera = new Camera();
>    Phone phone = new Phone();
>    Computer computer  = new Computer();
>    computer.working(phone); 
>    computer.working(camera);
>}
>```

##### 基本介绍

>接口就是给出一些没有实现的方法，封装到一起，到某个类要使用的时候，在根据具体情况吧这些方法写出
>
>* 语法
>
>  >interface 接口名{
>  >
>  >​     //属性
>  >
>  >​     //方法
>  >
>  >​        ==**在接口，抽象方法可以省略abstract关键字**==
>  >
>  >}
>  >
>  >class 类名 implements 接口{
>  >
>  >​     自己的属性；
>  >
>  >​     自己的方法；
>  >
>  >​     ==必须实现的接口的抽象方法==
>  >
>  >}
>  >
>  >*ps:在jdk7.0以前 接口里的所有方法都没有方法体；*
>  >
>  >*在jdk8.0后接口类可以有静态方法，默认方法，即接口中可以有方法的具体实现*
>  >
>  >```java
>  >interface A{
>  >    //属性
>  >    public int n1 = 10;
>  >    //抽象方法，可以省略abstract关键字
>  >    public void f1();   //等价于 public abstract void f1();
>  >    
>  >    //在jdk8.0之后，可以有默认实现方法，需要使用default关键字修饰
>  >    default public void OK(){
>  >        System.out.println("OK...");
>  >    }
>  >    //在jdk8.0之后，可以有静态方法
>  >    static public void cry(){
>  >        System.out.println("Cry...");
>  >    }
>  >}
>  >```

##### 应用场景

>接口可以在一定程度上实现代码规范
>
>例如:在写MySQL、DB2、Oracle的数据库connect以及close方法时，不同的程序员可能写的名称都不相同
>
>如A写的f1()/f2() B写的con()/close() C写的connect()/shutDown
>
>所以为了规范，我们可以定义 DBInterface接口，让其来implement接口中的抽象方法，达到规范的效果

##### 注意事项和细节

>1. 接口不能被实例化
>
>2. 接口中所有的方法是==public==方法，接口中抽象方法==可以不用abstract修饰==
>
>3. 一个普通类实现接口，必须将其的所有的方法都实现(除静态方法)
>
>  ```java
>  interface A{
>      //属性
>      public int n1 = 10;
>      //抽象方法，可以省略abstract关键字
>      public void f1();   //等价于 public abstract void f1();
>
>      //在jdk8.0之后，可以有默认实现方法，需要使用default关键字修饰
>      default void OK(){
>          System.out.println("OK...");
>      }
>      //在jdk8.0之后，可以有静态方法
>      static public void cry(){
>          System.out.println("Cry...");
>      }
>  }
>  class B implements A{
>      @Override
>      public void f1() {}
>      @Override
>      public void OK() {}
>  }
>
>4. 抽象类实现接口，可以不用实现接口的所有方法
>
>5. 一个类同时可以实现多个接口
>
>6. 接口中的属性，只能是final的，而且是==public static final==修饰符。比如int a = 1;实际上是public static final int a = 1(必须初始化)
>
>7. 一个接口不能继承其他的类，但是可以继承多个别的接口，此时不再使用implements
>
>   ```java
>   interface A{};
>   interface B{};
>   interface C extends A,B{  
>   };
>
>8. 接口的修饰符只能是public 和 默认，这点和类的修饰符一样
>

##### 接口vs继承

>实现接口机制是单继承机制的一种补充，即当子类继承了父类，就自动的拥有了父类的功能，如果子类需要扩展功能，可以通过实现接口的方式来扩展
>
>* 接口和继承解决的问题不同
>
>  >继承的价值主要在于：解决==代码的复用性和可维护性==
>  >
>  >接口的价值主要在于：设计，设计好各种规范(方法)，让其他类去实现这些方法
>
>* 接口比继承更加灵活
>
>  >接口比继承更加灵活，继承是满足==is - a==的关系，而接口只需满足==like a==的关系
>
>* 接口在一定程度上实现了代码解耦[即 ==接口规范性 + 动态绑定机制==]

##### 接口多态特性

>1. 多态参数
>
>   >在前面的USB接口案例，USB usb，既可以接收手机对象，又可以接收相机对象，就体现了接口的多态(接口引用可以指向实现了接口的类的对象实例)
>
>   ```java
>   interface UsbInter{
>       void start();
>       void stop();
>   }
>   class Phone implements UsbInter{
>       @Override
>       public void start() {
>           System.out.println("Phone正在运行");
>       }
>   
>       @Override
>       public void stop() {
>           System.out.println("Phone停止运行");
>       }
>   }
>   class iPad implements UsbInter{
>       @Override
>       public void start() {
>           System.out.println("iPad正在运行");
>       }
>       @Override
>       public void stop() {
>           System.out.println("iPad停止运行");
>       }
>   }
>   class Computer{
>       public void work(UsbInter usbInter){
>           //这里就体现了接口的多态
>           usbInter.start();
>           usbInter.start();
>       }
>   }
>   ```
>
>   ---
>
>   ```java
>   //接口类型的引用可以指向实现了接口的对象实例
>   //这也就是参数多态的本质
>   main(){
>       If if = new Monster();
>   }
>   
>   interface IF{}
>   class Monster implements IF{}
>
>2. 多态数组
>
>   >演示一个案例：给Usb数组中，存放Phone和相机对象，Phone类还有一个特有的方法call()，请遍历Usb数组，如果是Phone对象，除了调用Usb接口定义的方法外，还需要调用Phone特有的方法call
>   >
>   >```java
>   >public class TestEmployee {
>   >    public static void main(String[] args){
>   >        Usb[] usbs = new Usb[2];
>   >        usbs[0] = new Phone();
>   >        usbs[1] = new Camera();
>   >
>   >        for(int i = 0; i < usbs.length; i++){
>   >            usbs[i].start();//动态绑定机制
>   >            if(usbs[i] instanceof Phone){//进行运行类型判断
>   >                ((Phone)usbs[i]).call();//向下转型
>   >            }
>   >        }
>   >    }
>   >}
>   >interface Usb{
>   >    void start();
>   >}
>   >class Phone implements Usb{
>   >    public void call(){
>   >        System.out.println("Call is working...");
>   >    }
>   >
>   >    @Override
>   >    public void start() {
>   >        System.out.println("Phone starts...");
>   >    }
>   >}
>   >class Camera implements Usb{
>   >    @Override
>   >    public void start() {
>   >        System.out.println("Camera starts...");
>   >    }
>   >}
>   >```
>
>3. 接口存在多态传递现象
>
>   ```java
>   public class TestEmployee {
>       public static void main(String[] args) {
>           //接口类型的变量可以指向实现了该接口的对象实例
>           A a = new C();
>           //如果B接口继承了A接口，同时C类实现了B接口
>           //那么实际上相当于C类也实现了A接口
>           B b = new C();
>       }
>   }
>   interface A{ }
>   interface B extends A{ }
>   class C implements B{
>   }
>   ```

*ps：类的五大成员：(1)属性；(2)方法；(3)构造器；(4)代码块；(5)内部类*

#### 内部类

##### 基本介绍

>一个类的内部又完整的嵌套了另一个类结构。被嵌套的类称为内部类(inner class)，嵌套其他类的类称为外部类(outter class)。是我们类的第五大成员，内部类最大的特点就是可以直接访问私有属性，并且可以体现类与类之间的包含关系

##### 基本语法

>```java
>class Outer{//外部类
>    class Inner{//内部类
>    }
>}
>class Outer{//其他外部类
>}

##### 内部类的分类

>* 定义在外部类局部位置上(比如方法内)：
>
>1. 局部内部类(有类名)
>2. 匿名内部类(没有类名，重点)
>
>* 定义在外部类的成员位置上
>
>1. 成员内部类(没有static修饰)
>2. 静态内部类(使用static修饰)

###### 局部内部类

>说明：局部内部类是定义在外部类的局部位置，比如方法中，并且有类名
>
>1. 可以直接访问外部类的所有成员，包含私有的
>2. 不能添加访问修饰符，因为它的地位就是一个局部变量。局部变量是不能使用访问修饰符的。但是可以使用final修饰，因为局部变量也可以使用final
>3. 作用域：仅仅在定义它的方法或代码块中
>4. 局部内部类-->访问-->外部类的成员[访问方式：==直接访问==]
>5. 外部类-->访问-->局部内部类的成员，访问方式：==创建对象再访问==[必须在作用域中]
>
>```java
>class Outer{
>    private int n1 = 100;
>    private void m2(){}
>    public void m1(){
>        //1.局部内部类是定义在外部类的局部位置，通常在方法内
>        //2.不能添加访问修饰符，但是可以使用final修饰
>        //3.作用域：仅仅在定义它的方法或者代码块中
>        final class Inner{//局部内部类(本质仍然是一个类)
>            //可以直接访问外部类的所有成员，包含私有的
>            private int n1 = 10;
>            //f1()遵守就近原则，输出10;如果想使用外部类的n1，则使用Outer.this.n1
>            //其中Outer.this就是调用了m1()方法的对象，所以Outer.this.n1可以访问到外部类
>            public void f1(){
>                //5.局部内部类可以直接访问外部类的成员
>                System.out.println("n1 = " + n1); //可以直接访问私有成员/属性
>                m2();
>            }
>        }
>        //这里加了final，所以不可以被继承
>//        class Inner02 extends Inner{
>//        }
>        //6.外部类在方法中，可以创建Inner对象，然后调用方法
>        Inner inner = new Inner();
>        inner.f1();
>    }
>}
>```
>
>6. 外部其他类-->不能访问-->局部内部类(因为 局部内部类地位是一个局部变量)
>7. 如果外部类和局部内部类的成员重名时，默认==遵循就近原则==，如果想访问外部类的成员，则可以使用(外部类名.this.成员)去访问

###### 匿名内部类

>说明：匿名内部类是定义在外部类的局部位置，比如方法中，并且没有类名
>
>1. 匿名内部类的基本语法
>
>  ```java
>  //（1）本质是类（2）内部类(3)该类没有名字(4)同时还是一个对象
>  new 类或接口(参数列表){
>      类体
>  };//系统会为匿名内部类进行名称的分配
>  ```
>
>2. 基于接口的匿名内部类
>
>  ```java
>  class Outer{
>      private int n1 = 10;
>      public void method(){
>          //基于接口的匿名内部类
>          //1.需求：想使用A接口，并创建对象
>          //2.传统方式，写一个类，实现该接口，并创建对象
>          //3.然而当我们的需求是该类只使用一次，此时new一个对象会造成资源的浪费
>          A a = new Tiger();
>          a.cry();
>          //4.此时我们可以使用匿名内部类来简化开发
>          //5.tiger的编译类型是A接口，运行类型是匿名内部类
>          /**
>           * 我们看底层其运行类型的匿名内部类   XXXX = Outer$1系统在底层会分配一个类名给匿名内部类
>           * class XXXX implements A{
>           *  @Override
>              public void cry() {
>              System.out.println("tiger is crying...");}
>           * }
>           */
>     //6.jdk底层在创建匿名内部类 Outer$1，立即创建了Outer$1的实例，并且将地址返回给tiger的引用    
>    //7.匿名内部类使用一次，就不能使用(不是tiger引用，tiger指向的对象存在，类不存在了！！！)
>    //与Android里面的Button之类的很像，onCreate很像
>          A tiger = new A(){
>              @Override
>              public void cry() {
>                  System.out.println("tiger is crying...");
>              }
>          };
>          tiger.cry();
>      }
>  }
>  interface A{
>      public void cry();
>  }
>  class Tiger implements A{
>      @Override
>      public void cry() {
>          System.out.println("tiger is crying...");
>      }
>  }
>  ```
>
> ---
>
>3. 基于类的匿名内部类 
>
>  ```java
>  class Outer{
>      private int n1 = 10;
>      public void method() {
>          //基于类的匿名内部类
>          //1. b的编译类型是B
>          //2. (接上)b的运行类型是Outer$2
>          //3. 匿名内部类 class Outer$2 extends B{
>          // @Override
>          //            public void test() {
>          //                System.out.println("匿名内部类重写了test方法");
>          //            }
>          // }
>          //4.同时也直接返回了匿名内部类Outer$2的对象
>          //这个参数列表会传递给构造器
>          B b = new B("jack"){
>              @Override
>              public void test() {
>                  System.out.println("匿名内部类重写了test方法");
>              }
>          };
>          b.test();
>          //基于抽象类的匿名内部类
>          C c = new C(){
>              @Override
>              void say() {
>                  System.out.println("匿名内部类重写了抽象类的say方法");
>              }
>          };
>          c.say();//动态绑定机制，真实运行类型是Outer$3
>      }
>  }
>  class B{
>      public B(String name) {
>      }
>      public void test(){
>      }
>  }
>  abstract class C{
>      abstract void say();
>  }
>  ```
>
>4. 匿名内部类细节
>
>  >* 匿名内部类的语法比较奇特，因为匿名内部类既是一个类的定义，同时它本身也是一个对象，因此从语法上看，它既有定义类的特征，也有创建对象的特征，对前面的代码分析可以看出这个特点，因此可以调用匿名内部类方法
>  >
>  >```java
>  >new C(){
>  >    @Override
>  >    void say() {
>  >        System.out.println("匿名内部类重写了抽象类的say方法");
>  >    }
>  >}.say();
>  >//本质为(匿名内部类对象).say()
>  >```
>  >
>  >* 可以直接访问外部类的所有成员，包括私有的
>  >* 不能添加访问修饰符，地位相当于一个局部变量
>  >* 作用域：仅仅在定义它的方法或代码块中
>  >* 匿名内部类--->访问--->外部类成员[==直接访问==]
>  >* 外部其他类--->不能访问--->匿名内部类(因为匿名内部类地位是一个局部变量)
>  >* 如果外部类和内部类的成员重名时，内部类访问的话，遵循就近原则，如果想访问外部类的成员，则可以使用(***==外部类名.this.成员==***)去访问
>  
>5. 匿名内部类的最佳实践
>
>   >当做实参直接传递，简洁高效
>   >
>   >```java
>   >public class InnerClass{
>   >    public static void main(String[] args){
>   >        f1(new A(){
>   >            @Override
>   >            public void show(){
>   >                System.out.println("匿名内部类调用了方法");
>   >            }
>   >        });
>   >    }
>   >    public static void f1(A a){
>   >        a.show();
>   >    }
>   >}
>   >interface A{
>   >    void show();
>   >}
>   >```
>

###### 成员内部类

>说明：成员内部类是定义在外部类的成员位置，没有static修饰
>
>1. 可以直接访问外部类的所有成员，包括私有的
>2. 可以添加任意访问修饰符(public/protected/默认/private)，其地位相当于类成员
>
>```java
>class Outer02{
>    private int n = 1;
>    class Inner02{
>        public void say(){
>            System.out.println("n1 = " + n);
>        }
>    }
>    private void f1(){
>        Inner02 inner02 = new Inner02();
>        inner02.say();
>    }
>}
>```
>
>3. 作用域和外部类的其他成员一样，为整个类体，在外部列的成员方法中创建成员内部类对象，再调用方法
>
>4. 成员内部类-->访问-->外部类[访问方式：直接访问]
>
>5. 外部其它类-->访问-->成员内部类
>
>   > 两种方式
>   >
>   > * ```java
>   >   Outer outer = new Outer();
>   >   //相当于将new Inner()当做了outer的一个成员
>   >   Outer.Inner inner = outer.new Inner();
>   >   ```
>   >
>   > * ```java
>   >   //在外部类中写一个方法，方法直接返回一个Inner类的实例
>   >   class Outer{
>   >       public Inner getInnerInstance{
>   >           return new Inner();
>   >       }
>   >   }
>   >   ```

###### 静态内部类

>说明：静态内部类是定义在外部类的成员位置，并且有static修饰
>
>1. 可以直接访问外部类的所有静态成员，包含私有的，但不能直接访问非静态成员
>
>2. 可以添加任意的访问修饰符(public/protected/默认/private)，因为其地位就是一个成员
>
>3. 作用域：同其他成员，为整个类
>
>4. 静态内部类-->访问-->外部类(比如：静态属性)[访问方式：直接访问所有静态成员]
>
>5. 外部类-->访问-->静态内部类[访问方式：创建对象再访问]
>
>6. 主要的语法同成员内部类相似
>
>   >* 不过在外部类调用静态内部类时，可以直接通过外部类类名进行new和访问
>   >
>   >* 而且由于静态内部类只能访问静态的属性和方法，所以当出现重名时，遵循就近原则，可以使用外部类名.成员访问(==***因为此时，静态的成员不能有this***==)

###### 注意事项

>* 局部内部类是不能使用访问修饰符修饰的(public/protected/默认/private)
>
>* 匿名内部类不用管，只使用一次
>
>* 成员内部类和静态内部类均可以使用访问修饰符修饰，其在本质上是一个类成员
>
>  ```java
>  public class hwTest2{
>      public static void main(String[] args) {
>          E e = new E();
>          E.F f= e.new F();
>          f.f();
>      }
>  }
>  class E{
>      public static class D{
>          public void f(){
>              System.out.println("成员内部类方法被访问");
>          }
>      }
>      public class F{
>          public void f(){
>              System.out.println("需要创建外部类对象,再进行内部类创建");
>          }
>      }
>  }
>  ```

