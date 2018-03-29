exports.devServer = ({ host, port } = {}) => ({
    devServer: {
        stats: "errors-only",
        host, // defaults to 'localhost'
        port, // defaults to 8080
        overlay: {
            errors: true,
            warnings: true,
        },
    },
});

exports.loadCSS = ({ include, exclude } = {}) => ({
    module: {
        rules: [{
            test: /\.css$/,
            include,
            exclude,

            use: ["style-loader", "css-loader"],
        }, ],
    },
});