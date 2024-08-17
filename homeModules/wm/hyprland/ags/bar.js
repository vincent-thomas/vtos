const hyprland = await Service.import("hyprland")

function Workspaces() {
    const activeId = hyprland.active.workspace.bind("id")
    const workspaces = hyprland.bind("workspaces")
        .as(ws => ws.map(({ id }) => Widget.Button({
            on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
            child: Widget.Label(`${id}`),
            class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
        })))

    return Widget.Box({
        class_name: "workspaces",
        children: workspaces,
    })
}


const leftBarSection = () => {
  return Widget.Box({
    spacing: 2,
    children: [
       Workspaces()
    ],
  });
};

const centerBarSection = () => {
  return Widget.Box({
    spacing: 2,
    children: [],
  });
};

const rightBarSection = () => {
  return Widget.Box({
    hpack: "end",
    spacing: 2,
    children: [
    ],
  });
};


export const bar = (monitor = 0) => {
  return Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    css: `
      background-color: black;
    `,
    //className: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    margins: [2, 2],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      //className: "bar-center-box",
      start_widget: leftBarSection(),
      center_widget: centerBarSection(),
      end_widget: rightBarSection(),
    }),
  });
};


