356:2021-9-4 10:34

### JAVA面向对象(中级)

#### 包

##### 包的作用

>1. 区分相同名字的类
>2. 当类很多时，可以很好的管理类[看 JAVA API 文档]
>3. 控制访问范围

---

##### 包的基本语法

><font color="orange">**Package com.hspedu;**</font>
>
>1. package 关键字，表示打包
>2. com.hspedu 表示包名

---

##### 包的本质分析

>实际上就是创建不同的文件夹来保存文件，画出示意图

---

##### 包的命名规则

* >1. 只能包含数字、字母、下划线、小圆点，但不能以数字开头，不能是关键字或保留字
  >
  >2. 一般是小写字母 + 小圆点的格式
  >
  >   com.公司名.项目名.业务模块名
  >
  >   如：com.sina.crm.user    // 用户模块
  >
  >   ​        com.sina.crm.order //  订单模块
  >
  >   ​        com.sina.cem.utils   //  工具类

---

##### 常用的包

>java.lang.*   // lang包是基本包，默认引入，不需要再引入
>
>java.util.*     // util包，系统提供的工具包，工具类，可以使用Scanner
>
>java.net.*     // 网络包，网络开发
>
>java.awt.*     // 是做java的页面开发，GUI

---

##### package注意事项及细节

>1. package 的作用是声明当前类所在的包，需要放在类的最上面，一个类中最多只有一句package
>2. import 指令位置放在package下面，在类的定义之前，可以有多句且没有顺序限制要求

---

#### 访问修饰符

##### 基本介绍

> **Java 提供了四种访问控制修饰符号，控制方法和属性(成员变量)的访问权限(范围)**

> 1. 公开级别：public 修饰，对外公开
> 2. 受保护级别：protected 修饰，对子类和同一个包中的类公开
> 3. 默认级别：没有修饰符号(default) ，像同一个包的类公开
> 4. 私有级别：private修饰，只有类本身可以访问

---

| 访问级别 | 访问控制修饰符 | 同类 | 同包 | 子类 | 不同包 |
| :------: | :------------: | :--: | :--: | :--: | :----: |
|   公开   |     public     |  O   |  O   |  O   |   O    |
|  受保护  |   protected    |  O   |  O   |  O   |   X    |
|   默认   |   没有修饰符   |  O   |  O   |  X   |   X    |
|   私有   |    private     |  O   |  X   |  X   |   X    |

---

##### 注意事项

>1. 修饰符可以用来修饰类的属性，成员方法以及类
>2. 只有default以及public可以修饰类，并且遵循上述权限的特点
>3. 关于子类回留到继承extend进一步深入讲解
>4. 成员方法的访问规则和属性完全一样

---

#### 封装(Encapsulation)

##### 基本介绍

>把抽象出的数据[属性]和对数据的操作[方法]封装在一起，数据被保护在内部，程序的其他部分只有通过授权的操作[方法]，才能对数据进行操作

---

##### 封装的好处

>1. 隐藏实现的细节
>2. 可以对数据进行验证，保证安全合理性

---

##### 封装的步骤

>1. 属性进行私有化
>2. 提供共有的set、get方法，用于对属性判断并赋值

---

##### 封装与构造器

```Java
    public Dog(int ear, int eyes) {
        this.setEar(ear);
        this.setEyes(eyes);
    } // 将setXxx方法与构造器相结合
```

---

#### 继承(Extends)

##### Why

>主要是解决代码复用性的问题
>
>>继承可以解决代码复用，让我们的编程更加接近人类思维，当多个类存在相同的属性[变量]和方法时，可以从这些类中抽象出父类，在父类中定义这些相同的属性和方法，所有的子列不需要重新定义这些属性和方法，只需要extends来声明继承父类即可
>
>1. 子类又叫派生类
>2. 父类又叫超类(super)，基类
>3. 子类会自动拥有父类定义的属性和方法

---

##### 继承的深入讨论/细节问题

>1. 子类继承了所有的属性和方法，<u>**非私有的属性和方法可以在子类直接访问**</u>，但是私有属性(方法)不能在子类直接访问，要通过共有的方法去访问
>2. 子类必须调用父类的构造器，完成父类的初始化
>3. 当创建子类对象时，不管使用子类的哪个构造器，默认情况下总会去调用父类的无参构造器，如果父类没有提供无参构造器，则必须在子类的构造器中用super去指定使用父类的哪个构造器来完成父类的初始化工作
>4. 如果希望指定去调用父类的某个构造器，则显示的调用 super(形参列表)
>5. super在使用时，放在构造器的第一行
>6. super()和this()都只能放在构造器的第一行，所以这两个方法不能共存在一个构造器中
>7. java所有类都是Object类的子类，Object是所有类的基类
>8. 父类构造器调用不限于直接父类，将一直往上追溯到Object类
>9. 子类最多只能继承一个父类(直接继承)，即java中是单继承机制
>10. 不能滥用继承，子类和父类之间必须满足is a 的逻辑关系

---

##### 继承的本质

>当子类对象创建好后，建立查找关系
>
><img src="C:\Users\020227\Desktop\大二上技术进程\韩顺平java\Java面向对象\003.jpg" style="zoom:40%;" />
>
>1. 首先看子类是否有该属性
>2. 如果子类有这个属性，并且可以访问，则返回信息
>3. 如果子类没有这个属性，就看父类有没有这个属性（如果父类有该属性，并且可以访问，则返回信息）
>4. 如果父类没有则一直往上查询，直到Object类

##### super关键字

* super代表父类的引用，用于访问父类的属性、方法、构造器

* >1. 访问父类的属性，但不能访问父类的private属性   <font color="orange">**super.属性名**</font>
  >2. 访问父类的方法，但不能访问private方法    <font color="orange">**super.方法名(形参列表)**</font>
  >3. 访问父类的构造器

###### super关键字细节

>1. 调用父类的构造器的好处：分工明确，父类属性由父类初始化，子类的属性由子类初始化
>2. 当子类中有和父类的成员(属性和方法)重名时，为了访问父类的成员，必须通过super
>3. super的访问不限于直接父类，如果多个基类都有同名的成员，使用super访问遵循就近原则，同时遵循访问权限的规则

###### super与this的比较

| No.  |   区别点   |                           this                           |                  super                   |
| :--: | :--------: | :------------------------------------------------------: | :--------------------------------------: |
|  1   |  访问属性  | 访问本类中的属性，如果本类中没有此属性则从父类中继续查询 |             访问父类中的属性             |
|  2   |  调用方法  |  访问本类中的方法，如果本类中没有此方法则从父类继续查询  |           直接访问父类中的方法           |
|  3   | 调用构造器 |           调用本类构造器，必须放在构造器的首行           | 调用父类构造器，必须放在子类构造器的首行 |
|  4   |    特殊    |                       表示当前对象                       |            子类中访问父类对象            |

##### 方法的重写/覆盖(override)

###### 基本介绍

* >1. 方法覆盖重写即子类有一个方法，和父类的某个方法名称、返回类型、参数列表都相同，那么就说子类的这个方法覆盖了父类的方法

###### 方法重写的细节

>1. 子类的方法的参数，方法名称，要和父类的方法参数，方法名称完全一样
>
>2. 子类方法的返回类型和父类的返回类型一样，或者是父类返回类型的子类
>
>  ```Java
>  public Object getInfo(){}     // 父类
>  public String getInfo(){}     // 子类
>  ```
>
>3. 子类方法不能小于父类方法的访问权限
>
>  ```Java
>  void sayOK(){}                // 父类
>  public void sayOK(){}         // 子类
>  ```
>  
>  

<img src="C:\Users\020227\Desktop\大二上技术进程\韩顺平java\Java面向对象\004.jpg" style="zoom:40%;" />

#### 多态（polymorphic）

##### 多态基本介绍

>==方法或对象==具有多种形态，是面向对象的第三大特征，多态是建立在封装和继承基础上的
>
>1. 方法的多态
>
>  *ps:==重写和重载==就体现了多态*
>
>2. 对象的多态(<font color="red">**core**</font>)
>
>   * 对象的编译类型和运行类型可以不一致，编译类型在定义时，就确定，不能变化
>   * 对象的运行类型是可以变换的，可以通过$getClass()$来查看运行类型
>   * 编译类型看 = 号的左边，运行类型看 = 号的右边

##### 对象的多态

>1. 一个对象的编译类型和运行类型可以不一致
>
>2. 编译类型在定义对象时就确定了，不能改变
>
>3. 运行类型是可以改变的
>
>4. 编译类型看定义时 '=' 的左边，运行看 '=' 的右边
>
>5. 
>  
>  ```JAVA
>  //animal的编译类型是Animal，可以接受(指向)Animal子类的对象
>  //food的编译类型是Food，可以接受(指向)Food子类的对象
>  public void feed (Animal animal, Food food){
>      ...
>  }
>  ```
>  
>  
>

##### 向上转型

>多态的前提是：两个对象(类)存在继承关系
>
>多态的==**向上转型**==
>
>* 本质：<u>***父类的引用指向了子类的对象***</u>
>
>* 语法：父类类型 引用名 = new 子类对象();
>
>* 特点：编译类型看左边，运行类型看右边
>
>* >可以调用父类中的所有成员(需遵守访问权限)
>  >
>  >不能调用子类中的特有成员/特有方法
>  >
>  >**<u>*ps:因为在编译阶段，能调用哪些成员(属性/方法)是由编译类型决定*</u>**
>  >
>  >最终运行效果要看子类的具体实现$\rightarrow$从子类开始查找
>
>* 调用成员时，同样遵循之前的规则
>
>  >1. 先找本类，如果有，则调用
>  >
>  >2. 如果没有，则找父类(如果有，且可以访问则调用；如果有但是不能访问报cannot access错误)
>  >
>  >3. 如果没有，继续寻找父类
>  >
>  >4. >如果查找成员的过程中，找到了但是不能访问，则报错，cannot access
>  >   >
>  >   >如果一直查询到Object仍为查询到，则提示方法不存在

##### 向下转型

>多态的==**向下转型**==
>
>* 语法：子类类型 引用名 = (子类类型) 父类引用;
>
>* 本质：改变引用的编译类型<u>***(将原来指向子类对象的父类引用强转为子类引用)***</u>
>
>* 只能强转父类的引用，不能强转父类的对象
>
>* 要求父类的引用必须指向的是当前目标类型的对象
>
> <u>***因为对象是已经创建好的，不能进行改变***</u>
>
>* 可以调用子类类型中所有的成员
>
>```JAVA
>Animal animal1 = new Cat();
>Animal animal2 = new Animal();
>//调用后可以实现访问Cat中特有的成员
>Cat cat1 = (Cat) animal1; // ---> 即向下转型
>cat.CatEatMouse();// OK
>//调用后仍然不能访问Cat中特有的成员，因为对象是创建好的，只是由于不同的引用导致其编译类型不同，所以即使改了其引用名仍然不能访问到Cat对象
>Cat cat2 = (Cat) animal2; 
>Dog dog = (Dog) animal1;
>//均会报ClassCastException类异常
>```
>
>

##### 多态的细节(属性&instanceof)

>1. 属性没有重写之说，属性的值看编译类型
>
>  ```JAVA
>  Base base = new Sub();
>  System.out.println(base.count);
>  //这里会输出10.主要是属性不能重写，编译类型的属性是什么就输出什么
>  class Base {
>      int count = 10;
>  }
>  class Sub extends Bass{
>      int count = 20;
>  }
>  ```
>
>  
>
>2. instanceof比较操作符：用于判断对象的==**运行类型**==是否为XX类型或者XX类型的子类
>
>  ```java
>  BB bb = new BB();
>  AA aa = new BB();
>  System.out.println(bb instanceof AA);   //true
>  System.out.println(bb instanceof BB);   //true
>  System.out.println(aa instanceof AA);   //true
>  System.out.println(aa instanceof BB);   //true
>  
>  class AA{
>      ...    
>  }
>  class BB extends AA{
>      ...
>  }
>  ```
>
>  
>
>3. 多态练习
>

##### 动态绑定机制($important$)

>1. 当调用**==对象方法==**的时候，该方法会和对象的内存地址/运行类型绑定
>
>2. 当调用**==对象属性==**时，没有动态绑定机制，哪里声明，哪里使用

```Java
A a = new B();
System.out.println(a.sum());   //getI()==20 + 10  ====> 输出20 + 10 = 30
System.out.println(a.sum1());  //此时返回A类的i ===> 输出10 + 10 = 20

class A {
    public int i = 10;
    public int sum(){
        //此时调用了动态绑定机制，由于引用a的运行类型(对象)是B类，所以此时会跟B类的getI进行绑定
        return getI() + 10; 
    }
    public int getI(){
        return i;
    }
    public int sum1() {
        //对象的属性没有动态绑定机制，此时直接使用A类中声明的i 
        return i + 10;
    }
}
class B {
    public int i = 20;
    public int getI(){
        return i;//哪里声明哪里返回，所以返回子类的i 
    }
}
```

##### 多态数组

>数组的定义类型为父类类型，里面保存的实际元素类型是子类类型
>
>```Java
>Person[] persons = new Person[5];
>//name, age, score, salary
>persons[0] = new Person("Jack", 25);
>persons[1] = new Student("Tom", 20, 100);
>persons[2]...
>persons[3] = new Teacher("Scott", 40, 20000);
>persons[4]...
>for(int i = 0; i < persons.length; i++){ // 编译类型都是Person
>    //为了调用Student类中的特有方法
>    if(persons[i] instanceof Student){
>        //study是在Student类中特殊定义的方法
>        ((Student)persons[i]).study(); //向下转型
>    }else if(persons[i] instanceof Teacher){
>        //调用Teacher类中特殊定义的方法
>        ((Teacher)persons[i]).teach();
>    }else{
>    	persons[i].say(); // 动态绑定机制
>    }
>}
>```

##### 多态参数

>方法定义的形参类型为父类类型，实参类型允许为子类类型
>
>* 其实在之前已经有所涉及了 
>
>```Java
>//animal的编译类型是Animal，可以接受(指向)Animal子类的对象
>//food的编译类型是Food，可以接受(指向)Food子类的对象
>public void feed (Animal animal, Food food){
>    ...
>}

#### Object类详解

##### ==运算符($very$ $important$)==

>* 既可以判断基本类型，又可以判断引用类型
>* 如果判断基本类型，即判断其值是否相等
>* 如果判断引用类型，判断其地址是否相等，即判定是否是同一对象

---

>equals
>
>* 是Object类中的方法，只能判断引用类型
>* 默认判断是地址是否相等，但是子类中往往重写该方法，用于判断其内容是否相等，比如(Integer/String)

---

$Example$

```Java
Integer integer1 = new Integer(1000);
Integer integer2 = new Integer(1000);
System.out.println(integer1 == integer2);   // false
System.out.println(integer1.equals(integer2)); // true
```

---

##### equals重写范例

```java
public boolean equals(Object o) {
    //如果地址相同直接返回
    if (this == o) return true;
    //如果类型为空，或者类型不相同，直接返回假
    if (o == null || getClass() != o.getClass()) return false;
    //类型相同或有继承关系，进行向下转型之后再进行判断所有的属性是否相等
    Person person = (Person) o;
    return age == person.age &&
        Objects.equals(name, person.name);
}
```

##### hashCode

>1. 提高具有哈希结构的容器的效率
>2. 两个引用，如果指向的是同一个对象，则哈希值一定是一样的
>3. 两个引用，如果指向的是不同对象，则哈希值一定是不一样的
>4. 哈希值主要根据地址号来写，不能完全将哈希值等价为地址
>5. 实际上，由Object类定义的hashCode方法确实会针对不同的对象返回不同的整数（这一般是通过该对象的内部地址转换成一个整数来实现的）
>

##### toString

>1. Object的toString()源码
>
>   >* getClass().getName()  类的全类名（包名 + 类名）
>   >* Integer.toHexString(hashCode()) 将对象的hashCode值转成16进制
>   >
>   >```Java
>   >public String toString(){
>   >    return getClass().getName() + "@" + Integer.toHexString(hashCode());
>   >}
>   >```
>
>2. 重写toString()输出对象的属性信息
>
>   >Generate + toString()即可
>
>3. 当直接输出一个对象时，toString方法会被默认调用，比如
>
>   ```Java
>   System.out.println(monster)   //  --> 会默认调用Monster的toString方法

##### finalize

>当垃圾回收机制确定不存在对该对象的更多引用时，由对象的垃圾回收器调用此方法
>
>* 当对象被回收时，系统自动会调用该对象的finalize方法。子类可以重写该方法。做一些释放资源的操作比如释放：数据库连接，或者打开文件等
>* 什么时候被回收：当某个对象没有任何引用的时候，则jvm就认为该对象是一个垃圾对象，就会使用垃圾回收机制来销毁该对象，在销毁该对象前，会先调用finalize方法
>* 垃圾回收机制的调用，是由系统来决定的(有自己的GC算法)，也可以通过System.gc()主动触发垃圾回收机制
>
>***ps：在实际开发中几乎用不到***

#### 断点调试

><u>***重要提示：在断点调试过程中，是运行装态，是以对象的运行类型来执行的***</u>
>
>==F7 - step into== /==F8 - next line==/==shift + F8 - 跳出==/==F9 next break point*(resume)*==
