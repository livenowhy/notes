## Jenkins Pipeline 语法

###  1.1 Pipeline是什么

  Pipeline 是 Jenkins 的核心功能，提供一组可扩展的工具。通过 Pipeline 的 DSL 语法可以完成从简单到复杂的交付流水线实现。
  jenkins 的 Pipeline 是通过 Jenkinsfile （文本文件）来实现的。这个文件可以定义 Jenkins 的执行步骤，例如检出代码。

### 1.2 Jenkinsfile

  1、Jenkinsfile 使用两种语法进行编写，分别是声明式和脚本式。
  2、声明式和脚本式的流水线从根本上是不同的。
  3、声明式是 jenkins 流水线更友好的特性。
  4、脚本式的流水线语法，提供更丰富的语法特性。
  5、声明式流水线使编写和读取流水线代码更容易设计。

### 1.3 pipeline 演示

    Jenkinsfile的组成及每个部分的功能含义:
    1、agent:     指定node节点/workspace(定义好此流水线在某节点运行); agent none 在任何可用的节点上执行pipeline
    2、options:   运行选项（定义好此流水线运行时的一些选项，例如输出日志的时间）
    3、stages:    stages 包含多个 stage, stage 包含 steps。是流水线的每个步骤
    4、post:      定义好此流水线运行成功或者失败后，根据状态做一些任务


    pipeline{
    
        //指定运行此流水线的节点
        agent { node { label "build"}}

        //流水线的阶段
        stages{

            //阶段1 获取代码
            stage("CheckOut"){
                steps{
                script{
                        println("获取代码")
                    }
                }
            }

            // 阶段2 构建
            stage("Build"){
                steps{
                    script{
                        println("运行构建")
                    }
                }
            }
        }
        post {
            always{
                script{
                    println("流水线结束后，经常做的事情")
                }
            }

            success{
                script{
                    println("流水线成功后，要做的事情")
                }
            }
            failure{
                script{
                    println("流水线失败后，要做的事情")
                }
            }

            aborted{
                script{
                    println("流水线取消后，要做的事情")
                }
            }
        }
    }