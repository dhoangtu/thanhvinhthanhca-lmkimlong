% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Van Xin Ngài" }
  composer = "Tv. 5"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  %<> \tweak extra-offset #'(-6.5 . -2.2) _\markup { \bold "ĐK:" }
  \partial 4 a8. a16 |
  a8 gs4 e8 |
  c'4 b8 e |
  e8. e16 e8 c |
  a b4. ~ |
  b4 e,8 c' |
  c8. b16 a8 gs |
  b e,4 e8 |
  b' c gs4 |
  a2 \bar "||"
  
  a8. a16 b8 a |
  gs4. e16 c' |
  c8. a16 d8 d |
  e2 ~ |
  e4 d8 c16 (d) |
  e8 (d16 c) a8 b |
  b4. b16 b |
  e,8 b' c16 (b) gs8 |
  a2 ~ |
  a4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8. a16 |
  a8 gs4 e8 |
  a4 a8 a |
  gs8. gs16 a8 a |
  f e4. ~ |
  e4 e8 a |
  a8. e16 f8 e |
  d c4 c8 |
  d e e4 |
  c2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Con van xin Ngài,
  lạy Chúa, từ sáng sớm Chúa đã nhậm lời con,
  Từ sáng sớm con thân trình ước nguyện,
  rồi chăm chú đợi trông.
  <<
    {
      \set stanza = "1."
      Xin nghe tiếng van nài
      và thấu suốt điều con rên xiết,
      Ôi lạy Chúa là Vua con,
      xin nghe lời kêu cứu của con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Do ân nghĩa cao dầy,
	    được tiến bước vào nơi cung thánh,
	    Con phục bái và suy tôn,
	    Uy Danh Ngài con kính sợ liên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xin theo đức công bình mà hướng dẫn
	    để con đưa bước,
	    Quân thù vẫn rình theo con,
	    manh tâm bày mưu kế hại con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ai nương náu bên Ngài
	    nguyện ước sẽ được luôn vui sướng,
	    Ai mộ mến Thần Danh luôn,
	    hân hoan nhờ tay Chúa chờ che.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
    (set! all-grob-descriptions
          (cons ((@@ (lily) completize-grob-entry)
                 (cons grob-name grob-entry))
                all-grob-descriptions)))

#(add-grob-definition
   'StanzaNumberSpanner
   `((direction . ,LEFT)
     (font-series . bold)
     (padding . 0.5)
     (side-axis . ,X)
     (stencil . ,ly:text-interface::print)
     (X-offset . ,ly:side-position-interface::x-aligned-side)
     (Y-extent . ,grob::always-Y-extent-from-stencil)
     (meta . ((class . Spanner)
              (interfaces . (font-interface
                             side-position-interface
                             stanza-number-interface
                             text-interface))))))

\layout {
  \context {
    \Global
    \grobdescriptions #all-grob-descriptions
  }
  \context {
    \Score
    \remove Stanza_number_align_engraver
    \consists
      #(lambda (context)
         (let ((texts '())
               (syllables '()))
           (make-engraver
            (acknowledgers
             ((stanza-number-interface engraver grob source-engraver)
                (set! texts (cons grob texts)))
             ((lyric-syllable-interface engraver grob source-engraver)
                (set! syllables (cons grob syllables))))
            ((stop-translation-timestep engraver)
               (for-each
                (lambda (text)
                  (for-each
                   (lambda (syllable)

                     (ly:pointer-group-interface::add-grob text 'side-support-elements syllable))

                   syllables))
                texts)
               (set! syllables '())))))
  }
  \context {
    \Lyrics
    \remove Stanza_number_engraver
    \consists
      #(lambda (context)
         (let ((text #f))
           (make-engraver
            ((process-music engraver)
               (if (not text)
                   (let ((stanza (ly:context-property context 'stanza #f)))
                     (if stanza
                         (begin

                           (set! text (ly:engraver-make-grob engraver 'StanzaNumberSpanner '()))                            (let ((column (ly:context-property context 'currentCommandColumn)))

                             (ly:grob-set-property! text 'text stanza)
                             (ly:spanner-set-bound! text LEFT column)))))))
            ((finalize engraver)
               (if text

                   (let ((column (ly:context-property context 'currentCommandColumn)))

                     (ly:spanner-set-bound! text RIGHT column)))))))
    \override StanzaNumberSpanner.horizon-padding = 10000
  }
}
% kết thúc mã nguồn

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
