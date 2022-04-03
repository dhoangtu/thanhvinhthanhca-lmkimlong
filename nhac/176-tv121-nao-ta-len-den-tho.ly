% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Nào Ta Lên Đền Thờ" }
  composer = "Tv. 121"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 e8 c |
  c f16 f d8 f |
  g4 r8 g |
  c8. c16 b8 c |
  d e (e4 ~ |
  e) f8. e16 |
  d8 d d4 ~ |
  d8 b c8. d16 |
  c8 \slashedGrace { \once \stemDown a16 ( } g8) e f ~ |
  f f d16 (g) e (d) |
  c2 \bar "||" \break
  
  g'8 g g g ~ |
  g a f g16 (f) |
  d4 d8 e |
  e8. d16 g8 e16 (d) |
  c2 ~ |
  c4 c8 f |
  d8. g16 e8 \slashedGrace { \parenthesize e16 ( } g8)
  a2 ~ |
  a8 d,16 (g) e8 d |
  b \slashedGrace { \parenthesize b16 ( } d4)
  c8 |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8 c |
  c f16 f d8 f |
  g4 r8 f |
  e8. e16 d8 e |
  g c (c4 ~ |
  c) a8. c16 |
  b8 a g4 ~ |
  g8 g a8. g16 |
  e8 [e] c d ~ |
  d d b b |
  c2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Vui chừng nào khi thiên hạ bảo tôi:
  Nào ta lên đền thờ Thiên Chúa.
  Hỡi Giê -- ru -- sa -- lem
  Giờ đây chúng ta đã dừng chân,
  nơi cửa nội thành.
  <<
    {
      \set stanza = "1."
      Giê -- ru -- sa -- lem khác nào đô thị
      Được xây nên một khối vẹn toàn.
      Từng chi tộc, chi tộc
      \markup { \italic \underline "của" }
      Chúa,
      Trẩy hội lên đền
      \markup { \italic \underline "ở" }
      nơi đây.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con dân hân hoan tiến về nơi này
	    Cùng tuân theo lệnh Chúa ban truyền,
	    Tại đây đặt ngai tòa Đa -- vít
	    Sẽ công minh xử xét con dân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Mong sao Sa -- lem mãi được an bình,
	    Thịnh hưng cho kẻ mến yêu thành,
	    Mọi lũy thành luôn được
	    \markup { \italic \underline "ổn" }
	    cố
	    Với bao dinh thự mãi an ninh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Do bao anh em nghĩa tình thân thuộc,
	    Lòng ta mong thành mãi an bình,
	    Vì cung điện, cung điện
	    \markup { \italic \underline "của" }
	    Chúa,
	    Chúc ngươi luôn hạnh phúc an vui.
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
  page-count = #1
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
     (padding . 1)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
                    syllables))
                 texts)
                (set! syllables '())))))
   }
   \context {
     \Lyrics
     \remove Stanza_number_engraver
     \consists
       #(lambda (context)
          (let ((text #f)
                (last-stanza #f))
            (make-engraver
             ((process-music engraver)
                (let ((stanza (ly:context-property context 'stanza #f)))
                  (if (and stanza (not (equal? stanza last-stanza)))
                      (let ((column (ly:context-property context
'currentCommandColumn)))
                        (set! last-stanza stanza)
                        (if text
                            (ly:spanner-set-bound! text RIGHT column))

                        (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                        (ly:grob-set-property! text 'text stanza)
                        (ly:spanner-set-bound! text LEFT column)))))
             ((finalize engraver)
                (if text
                    (let ((column (ly:context-property context
'currentCommandColumn)))
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
