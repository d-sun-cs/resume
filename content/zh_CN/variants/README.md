# 中文简历变体

每个版本入口在 `versions/zh_CN/*.tex` 中设置 `\ResumeVariant`。

默认会使用 `content/zh_CN/shared/` 下的同名章节。如果某个投递版本需要改写其中一节，在这里新建对应目录和同名文件即可覆盖共享版本，例如：

- `content/zh_CN/variants/internet/projects.tex`
- `content/zh_CN/variants/state-owned/skills.tex`
- `content/zh_CN/variants/zte/activities.tex`
- `content/zh_CN/variants/zte/experience.tex`
- `content/zh_CN/variants/zte/projects.tex`
- `content/zh_CN/variants/zte/skills.tex`

当前可覆盖章节名：

- `header`
- `education`
- `skills`
- `experience`
- `projects`
- `activities`
