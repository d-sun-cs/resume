# 个人简历

本项目为个人简历 Latex 源码存放，同时包含效果图呈现，修改自项目 [resume](https://github.com/billryan/resume/)。仓库已按多版本简历组织，适合维护国企、互联网、英文等不同投递场景。

## 多版本结构

- `versions/`: 每份简历的入口文件，只负责声明版本名并加载模板。
- `src/`: 中文/英文通用模板，定义章节加载顺序和公共导言区。
- `content/zh_CN/shared/`: 中文简历共享章节。
- `content/zh_CN/variants/<版本名>/`: 中文简历某个版本的覆盖章节。
- `content/en_US/shared/`: 英文简历共享章节。
- `content/en_US/variants/<版本名>/`: 英文简历某个版本的覆盖章节。
- `build/`: 编译中间文件，自动生成，不提交。
- `dist/`: 最终 PDF 输出目录，`*.pdf` 直接提交到仓库，其他辅助文件不提交。

当前内置版本：

- `zh_CN/default`: 默认中文简历
- `zh_CN/internet`: 互联网投递版入口，当前复用默认内容
- `zh_CN/state-owned`: 国企投递版入口，当前复用默认内容
- `zh_CN/hpc`: 高性能计算投递版，覆盖技能、实习和项目章节
- `zh_CN/zte`: 中兴通讯投递版，覆盖技能、实习、项目和课余活动章节
- `en_US/default`: 默认英文简历

如果某个版本只想改一节，不需要复制整份简历。例如要改互联网版项目经历，新建 `content/zh_CN/variants/internet/projects.tex`，构建时会自动替代 `content/zh_CN/shared/projects.tex`。没有覆盖的章节继续复用 shared 内容。

## 项目说明

一个优雅的 \LaTeX\ 简历模板, 使用 \XeLaTeX\ 编译, 因为受不了古老的`res`和不太适合作为一页纸简历的`moderncv`, 遂自己动手写了这个模板， 受以下项目启发：

- [zachscrivena/simple-resume-cv](https://github.com/zachscrivena/simple-resume-cv)
- [res](https://www.ctan.org/pkg/res)
- [JianXu's CV](http://www.jianxu.net/en/files/JianXu_CV.pdf)
- [paciorek's CV/Resume template](http://www.stat.berkeley.edu/~paciorek/computingTips/Latex_template_creating_CV_.html)
- [How to write a LaTeX class file and design your own CV (Part 1) - ShareLaTeX](https://www.sharelatex.com/blog/2011/03/27/how-to-write-a-latex-class-file-and-design-your-own-cv.html)

*注：由于使用到 `fontspec` 包，编译器需选择 XeLaTeX。*

## 特性

- 极其容易定制和扩展 (`res`模板中枪倒地...)
- 完善的 Unicode 字体支持, 因为用的是 \XeLaTeX\ 嘛
- 完美的中文支持，使用 Adobefonts
- 支持 FontAwesome 4.3.0 (目前还不支持使用别名)

### 效果输出

![resume-zh_CN.png](./resume.preview.png)

## 使用方法

使用较新的 \LaTeX\ 发行版在本地计算机编译，编译器需选择 XeLaTeX。

```sh
make list              # 查看所有版本
make                   # 构建所有版本
make zh_CN-default     # 构建默认中文简历
make zh_CN-internet    # 构建互联网版中文简历
make zh_CN-state-owned # 构建国企版中文简历
make zh_CN-hpc         # 构建高性能计算版中文简历
make en_US-default     # 构建默认英文简历
make clean             # 删除 build/ 中间文件
make distclean         # 删除 build/ 和 dist/
```

正式 PDF 位于 `dist/`，例如 `dist/zh_CN-default.pdf`。`dist/` 中只应保留并提交正式 PDF；LaTeX 中间文件应留在 `build/` 或被 `make clean` 清理。

如果使用 Overleaf/ShareLaTeX 在线编译，可以上传整个仓库，并把主文件设置为 `versions/zh_CN/default.tex` 或其他 `versions/` 下的入口文件。

### VS Code / LaTeX Workshop

仓库内已提供 `.vscode/settings.json` 和 `.vscode/extensions.json`。打开 `versions/` 下的入口文件后，使用 LaTeX Workshop 的 Build LaTeX Project 即可编译当前版本。默认 recipe 会调用 Makefile 生成正式 PDF 到 `dist/`，文件名按版本命名，例如 `zh_CN-zte.pdf`；同时会把同一份 PDF 同步到 `build/latex-workshop/` 供 LaTeX Workshop 预览。LaTeX Workshop 的清理命令会调用 `make clean`，只清理 `build/` 和辅助文件，不删除 `dist/` 中准备提交的 PDF。

如果确定只需要中文简历的话单独克隆 `master` 分支即可, 需要注意的是该分支包含 Adobe 的宋楷黑仿四套中文字体，压缩包约为37MB。[下载地址](https://github.com/hijiangtao/resume/releases)

```
git clone https://github.com/hijiangtao/resume.git --branch master --depth 1 --single-branch <folder>
```

如果系统已确定安装有 Adobe 的四套中文字型，在文档的开始处使用包`zh_CN-Adobefonts_internal`, 如果没有安装则使用包`zh_CN-Adobefonts_external`, 在 ShareLaTeX 上编译需要使用包`zh_CN-Adobefonts_external`.

其他具体使用可参考给出的范例，都是极其简单易懂的宏，建议先看看 [How to write a LaTeX class file and design your own CV (Part 1) - ShareLaTeX](https://www.sharelatex.com/blog/2011/03/27/how-to-write-a-latex-class-file-and-design-your-own-cv.html) 和 [How to write a LaTeX class file and design your own CV (Part 2) - ShareLaTeX](https://www.sharelatex.com/blog/2013/06/28/how-to-write-a-latex-class-file-and-design-your-own-cv.html) 了解下该模板的简单背景，下面就一些新定义的宏做简要介绍。

### 宏

- `\name`: 姓名
- `\contactInfo`: 联系信息, 需要三项信息，分别是{邮箱}{手机号}{个人主页}
- `\basicContactInfo`: 简要的联系信息, 需要 项信息, 分别是{邮箱}{手机号}, 没有个人主页的用这个
- `\section`: 用于分节, 如教育背景, 实习/项目经历等
- `\subsection`: 用于小节标题, 无日期选项
- `\datedsubsection`: 用于小节标题, 简历中使用最广，第二项为时间区间，自动右对齐
- `\itemize`: 清单列表，简历中应用最广
- `\enumerate`: 枚举列表，数字标号

### FontAwesome

首先在 [Font Awesome Icons](http://fortawesome.github.io/Font-Awesome/icons/) 上选中自己想使用的图标(暂不支持 alias)，然后在 [fontawesome.sty](https://github.com/billryan/resume/blob/zh_CN/fontawesome.sty) 中找到相应的宏, 将其作为普通文本一样使用。

其他的可以自行参考相应 cls 和 tex 文件。

## License

[The MIT License (MIT)](http://opensource.org/licenses/MIT)

Copyrighted fonts are not subjected to this License.
