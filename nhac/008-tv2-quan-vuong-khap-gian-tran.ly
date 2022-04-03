% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Quân Vương Khắp Gian Trần" }
  composer = "Tv. 2"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  <> \tweak extra-offset #'(-6.5 . -2.5) _\markup { \bold "ĐK:" }
  \partial 4 c4 |
  g'4. g8 |
  g8. a16 f8 e |
  d4 g8 g |
  c,4 r8 c |
  f8. f16 d8 a' |
  a4 a16 (b) a8 |
  g4 g8 g |
  c4. c8 |
  c b c (d) |
  e4 e16 (f) e8 |
  a,4. a16 (b) |
  g4 d'8 d |
  \once \stemDown c4 \bar "||"
  
  g4 |
  g8. g16 e (d) g8 |
  c,4 b8 c |
  d d c (d) |
  e2 |
  f8. d16 d8 g |
  g2 |
  b8 b16 (a) g8 (a) |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c4 |
  g'4. g8 |
  g8. a16 f8 e |
  d4 g8 g |
  c,4 r8 c |
  f8. f16 d8 a' |
  a4 a16 (b) a8 |
  g4 g8 f |
  e4. e8 |
  a g a (b) |
  c4 c8 [a] |
  f4. f8 |
  e4 f8 g |
  <e c>4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Giờ đây quân vương khắp cõi gian trần
  hãy biết điều,
  Thủ lãnh khắp cùng thế giới hãy tỉnh ngộ,
  và thực tâm suy tôn thờ phượng Chúa,
  hãy run sợ phủ phục trước Thánh Nhan.
  <<
    {
      \set stanza = "1."
      Chúa phán: Chính Ta
      sẽ đặt Vị quân vương Ta chọn sẵn,
      Lên trị vì Si -- on,
      núi thánh của Ta.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Các nước cớ sao náo động
	    và vạn dân sao bày kế chống lại Vị Tân Vương,
	    tính kế viển vông.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Cứ đến khấn xin sẽ được vạn dân Ta bạn tặng đó,
	    Đây sản nghiệp Ta trao:
	    Khắp cõi trần gian.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
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
